import React, { useState } from 'react';
import { ComplaintModel, ComplaintStatus, ScreenRoute } from '../types';
import { ComplaintCard } from '../components/ComplaintCard';
import { Search, Filter, ClipboardList, PlusCircle } from 'lucide-react';

interface ComplaintHistoryScreenProps {
  complaints: ComplaintModel[];
  onNavigate: (route: ScreenRoute) => void;
  onViewDetails: (complaint: ComplaintModel) => void;
  language: 'en' | 'ta';
}

export const ComplaintHistoryScreen: React.FC<ComplaintHistoryScreenProps> = ({
  complaints,
  onNavigate,
  onViewDetails,
  language,
}) => {
  const [search, setSearch] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('all');

  const filtered = complaints.filter((c) => {
    const matchesSearch =
      search.trim() === '' ||
      c.title.toLowerCase().includes(search.toLowerCase()) ||
      c.complaintId.toLowerCase().includes(search.toLowerCase()) ||
      c.address.toLowerCase().includes(search.toLowerCase()) ||
      c.category.toLowerCase().includes(search.toLowerCase());

    const matchesStatus =
      statusFilter === 'all'
        ? true
        : statusFilter === 'inProgress'
        ? ['submitted', 'verified', 'assigned', 'inProgress'].includes(c.status)
        : c.status === statusFilter;

    return matchesSearch && matchesStatus;
  });

  const statuses = [
    { id: 'all', label: language === 'ta' ? 'அனைத்தும்' : 'All' },
    { id: 'inProgress', label: language === 'ta' ? 'நடவடிக்கையில்' : 'In Action' },
    { id: 'submitted', label: language === 'ta' ? 'பதிவானவை' : 'Submitted' },
    { id: 'verified', label: language === 'ta' ? 'சரிபார்க்கப்பட்டது' : 'Verified' },
    { id: 'resolved', label: language === 'ta' ? 'தீர்க்கப்பட்டவை' : 'Resolved' },
    { id: 'closed', label: language === 'ta' ? 'முடிவடைந்தது' : 'Closed' },
  ];

  return (
    <div id="complaint-history-screen" className="space-y-5 pb-24 pt-2">
      {/* Search and Filter Bar */}
      <div className="bg-white dark:bg-[#1E1E1E] rounded-2xl p-3 sm:p-4 border border-slate-200 dark:border-slate-800 shadow-xs space-y-3">
        <div className="relative">
          <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
          <input
            id="input-search-complaints"
            type="text"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder={
              language === 'ta'
                ? 'புகார் எண் அல்லது இடத்தை உள்ளிடுக...'
                : 'Search by complaint ID, area, category...'
            }
            className="w-full pl-10 pr-4 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs sm:text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
          />
        </div>

        {/* Status Pills */}
        <div className="flex items-center gap-1.5 overflow-x-auto pb-1 no-scrollbar">
          {statuses.map((st) => (
            <button
              key={st.id}
              id={`filter-status-${st.id}`}
              type="button"
              onClick={() => setStatusFilter(st.id)}
              className={`py-1 px-3 rounded-full text-xs font-semibold whitespace-nowrap transition-colors ${
                statusFilter === st.id
                  ? 'bg-[#00695C] text-white shadow-xs'
                  : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
              }`}
            >
              {st.label}
            </button>
          ))}
        </div>
      </div>

      {/* Results Header */}
      <div className="flex items-center justify-between text-xs text-slate-500 dark:text-slate-400 px-1">
        <span>Showing {filtered.length} complaints</span>
        <button
          type="button"
          onClick={() => onNavigate('report_complaint')}
          className="inline-flex items-center gap-1 font-semibold text-[#00695C] dark:text-[#00897B] hover:underline"
        >
          <PlusCircle className="w-3.5 h-3.5" />
          <span>New Report</span>
        </button>
      </div>

      {/* Complaints Grid */}
      {filtered.length === 0 ? (
        <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-10 text-center border border-slate-200 dark:border-slate-800 space-y-3">
          <div className="w-14 h-14 rounded-full bg-slate-100 dark:bg-slate-800 mx-auto flex items-center justify-center text-slate-400">
            <ClipboardList className="w-7 h-7" />
          </div>
          <h3 className="text-base font-bold text-slate-800 dark:text-slate-200">
            No complaints found
          </h3>
          <p className="text-xs text-slate-500 max-w-xs mx-auto">
            {search
              ? 'Try modifying your search query or removing the status filter.'
              : 'You have not submitted any complaints in this category yet.'}
          </p>
          <button
            type="button"
            onClick={() => onNavigate('report_complaint')}
            className="py-2.5 px-5 rounded-xl bg-[#00695C] text-white text-xs font-semibold hover:bg-[#004D40] transition-colors"
          >
            File a New Complaint
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {filtered.map((item) => (
            <ComplaintCard
              key={item.complaintId}
              complaint={item}
              onViewDetails={onViewDetails}
            />
          ))}
        </div>
      )}
    </div>
  );
};
