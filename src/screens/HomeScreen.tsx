import React, { useState } from 'react';
import { ComplaintModel, ScreenRoute, UserModel } from '../types';
import { ComplaintCard } from '../components/ComplaintCard';
import {
  PlusCircle,
  ClipboardList,
  ShieldAlert,
  Building2,
  Compass,
  Sparkles,
  TrendingUp,
  CheckCircle2,
  Clock,
  ArrowRight,
  Search,
  MapPin,
  AlertTriangle
} from 'lucide-react';

interface HomeScreenProps {
  user: UserModel | null;
  complaints: ComplaintModel[];
  onNavigate: (route: ScreenRoute) => void;
  onViewDetails: (complaint: ComplaintModel) => void;
  language: 'en' | 'ta';
}

export const HomeScreen: React.FC<HomeScreenProps> = ({
  user,
  complaints,
  onNavigate,
  onViewDetails,
  language,
}) => {
  const [filter, setFilter] = useState<'all' | 'inProgress' | 'resolved'>('all');
  const [searchQuery, setSearchQuery] = useState('');

  // Filter complaints
  const filteredComplaints = complaints.filter((c) => {
    const matchesFilter =
      filter === 'all'
        ? true
        : filter === 'inProgress'
        ? ['submitted', 'verified', 'assigned', 'inProgress'].includes(c.status)
        : c.status === 'resolved';

    const matchesSearch =
      searchQuery.trim() === '' ||
      c.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.address.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.complaintId.toLowerCase().includes(searchQuery.toLowerCase());

    return matchesFilter && matchesSearch;
  });

  const totalSubmitted = complaints.length;
  const inProgressCount = complaints.filter((c) =>
    ['submitted', 'verified', 'assigned', 'inProgress'].includes(c.status)
  ).length;
  const resolvedCount = complaints.filter((c) => c.status === 'resolved').length;

  return (
    <div id="home-screen" className="space-y-6 pb-20 pt-2 animate-fade-in">
      {/* Citizen Welcome Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-linear-to-r from-[#004D40] to-[#00695C] text-white p-6 sm:p-8 shadow-sm">
        <div className="relative z-10 space-y-3">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/15 backdrop-blur-md text-teal-100 text-xs font-semibold">
            <MapPin className="w-3.5 h-3.5 text-teal-300" />
            <span>Kanyakumari District • கன்னியாகுமரி</span>
          </div>

          <div>
            <h2 className="text-xl sm:text-2xl font-bold tracking-tight">
              {language === 'ta' ? 'வணக்கம், ' : 'Vanakkam, '}
              {user?.fullName || 'Citizen'}
            </h2>
            <p className="text-teal-100/90 text-xs sm:text-sm mt-1 max-w-md leading-relaxed">
              {language === 'ta'
                ? 'உங்கள் பகுதியில் உள்ள பொதுப் பிரச்சனைகளை எளிதாகப் பதிவு செய்து நேரடியாகத் தீர்வு காணுங்கள்.'
                : 'Report public civic issues in your neighborhood and track real-time resolution directly with authorities.'}
            </p>
          </div>

          <div className="pt-2 flex flex-wrap gap-2.5">
            <button
              id="hero-btn-report"
              type="button"
              onClick={() => onNavigate('report_complaint')}
              className="inline-flex items-center gap-2 py-2.5 px-4 rounded-xl bg-white text-[#004D40] text-xs sm:text-sm font-bold shadow-xs hover:bg-teal-50 transition-transform active:scale-98"
            >
              <PlusCircle className="w-4 h-4 text-[#00695C]" />
              <span>{language === 'ta' ? 'புதிய புகார் பதிவு' : 'Report Civic Issue'}</span>
            </button>

            <button
              id="hero-btn-emergency"
              type="button"
              onClick={() => onNavigate('emergency')}
              className="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl bg-red-600/90 hover:bg-red-600 text-white text-xs sm:text-sm font-bold shadow-xs transition-colors"
            >
              <ShieldAlert className="w-4 h-4" />
              <span>{language === 'ta' ? 'அவசர உதவி 24/7' : 'Emergency 24/7'}</span>
            </button>
          </div>
        </div>

        {/* Decorative background circle */}
        <div className="absolute -right-10 -bottom-10 w-48 h-48 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute right-12 top-4 w-28 h-28 rounded-full bg-teal-300/10 blur-xl pointer-events-none" />
      </div>

      {/* District Safety Alert Ticker */}
      <div className="bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-900/60 rounded-2xl p-3.5 flex items-center gap-3">
        <div className="w-8 h-8 rounded-xl bg-amber-100 dark:bg-amber-900/60 flex items-center justify-center shrink-0">
          <AlertTriangle className="w-4 h-4 text-amber-700 dark:text-amber-400" />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-xs font-semibold text-amber-900 dark:text-amber-200 truncate">
            District Sea Swell Alert: Coastal Security
          </p>
          <p className="text-[11px] text-amber-700 dark:text-amber-400 truncate">
            High wave warning along Kanyakumari & Colachel beaches. Please heed lifeguard flags.
          </p>
        </div>
      </div>

      {/* Quick Civic Action Grid */}
      <div className="space-y-3">
        <h3 className="text-sm font-bold text-slate-900 dark:text-white uppercase tracking-wider">
          {language === 'ta' ? 'அத்தியாவசிய சேவைகள்' : 'Civic Services Hub'}
        </h3>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {/* Report Issue */}
          <button
            id="hub-btn-report"
            type="button"
            onClick={() => onNavigate('report_complaint')}
            className="p-4 rounded-2xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 shadow-xs hover:border-[#00695C] transition-all text-left flex flex-col justify-between space-y-3 group"
          >
            <div className="w-10 h-10 rounded-xl bg-teal-50 dark:bg-teal-950/50 flex items-center justify-center text-[#00695C] dark:text-teal-300 group-hover:scale-105 transition-transform">
              <PlusCircle className="w-5 h-5" />
            </div>
            <div>
              <p className="text-xs font-bold text-slate-900 dark:text-white">
                {language === 'ta' ? 'புகார் பதிவு' : 'Report Issue'}
              </p>
              <p className="text-[11px] text-slate-500 dark:text-slate-400 mt-0.5">
                AI Auto-detect
              </p>
            </div>
          </button>

          {/* Track Complaints */}
          <button
            id="hub-btn-track"
            type="button"
            onClick={() => onNavigate('complaint_history')}
            className="p-4 rounded-2xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 shadow-xs hover:border-[#00695C] transition-all text-left flex flex-col justify-between space-y-3 group"
          >
            <div className="w-10 h-10 rounded-xl bg-blue-50 dark:bg-blue-950/50 flex items-center justify-center text-blue-600 dark:text-blue-300 group-hover:scale-105 transition-transform">
              <ClipboardList className="w-5 h-5" />
            </div>
            <div>
              <p className="text-xs font-bold text-slate-900 dark:text-white">
                {language === 'ta' ? 'புகார் நிலை' : 'Track Status'}
              </p>
              <p className="text-[11px] text-slate-500 dark:text-slate-400 mt-0.5">
                {complaints.length} Lodged
              </p>
            </div>
          </button>

          {/* Emergency */}
          <button
            id="hub-btn-emergency"
            type="button"
            onClick={() => onNavigate('emergency')}
            className="p-4 rounded-2xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 shadow-xs hover:border-red-400 transition-all text-left flex flex-col justify-between space-y-3 group"
          >
            <div className="w-10 h-10 rounded-xl bg-red-50 dark:bg-red-950/50 flex items-center justify-center text-red-600 dark:text-red-300 group-hover:scale-105 transition-transform">
              <ShieldAlert className="w-5 h-5" />
            </div>
            <div>
              <p className="text-xs font-bold text-slate-900 dark:text-white">
                {language === 'ta' ? 'அவசர உதவி' : 'Emergency'}
              </p>
              <p className="text-[11px] text-slate-500 dark:text-slate-400 mt-0.5">
                Police • 108 • Fire
              </p>
            </div>
          </button>

          {/* Government Offices */}
          <button
            id="hub-btn-gov"
            type="button"
            onClick={() => onNavigate('government_services')}
            className="p-4 rounded-2xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 shadow-xs hover:border-[#00695C] transition-all text-left flex flex-col justify-between space-y-3 group"
          >
            <div className="w-10 h-10 rounded-xl bg-emerald-50 dark:bg-emerald-950/50 flex items-center justify-center text-emerald-600 dark:text-emerald-300 group-hover:scale-105 transition-transform">
              <Building2 className="w-5 h-5" />
            </div>
            <div>
              <p className="text-xs font-bold text-slate-900 dark:text-white">
                {language === 'ta' ? 'அரசு அலுவலகங்கள்' : 'Govt Offices'}
              </p>
              <p className="text-[11px] text-slate-500 dark:text-slate-400 mt-0.5">
                Taluks & Municipal
              </p>
            </div>
          </button>
        </div>
      </div>

      {/* District Redressal Metric Counter */}
      <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-5 border border-slate-200 dark:border-slate-800 shadow-xs">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-xs font-bold text-slate-900 dark:text-white uppercase tracking-wider flex items-center gap-1.5">
            <TrendingUp className="w-4 h-4 text-[#00695C]" />
            <span>District Grievance Summary</span>
          </h3>
          <span className="text-[11px] font-semibold text-emerald-600 bg-emerald-50 dark:bg-emerald-950/50 px-2 py-0.5 rounded-full">
            92% Resolution Rate
          </span>
        </div>

        <div className="grid grid-cols-3 gap-2 text-center divide-x divide-slate-100 dark:divide-slate-800">
          <div className="px-2">
            <p className="text-xl sm:text-2xl font-extrabold text-slate-900 dark:text-white">
              {totalSubmitted}
            </p>
            <p className="text-[11px] text-slate-500 mt-0.5 font-medium">Total Issues</p>
          </div>
          <div className="px-2">
            <p className="text-xl sm:text-2xl font-extrabold text-amber-600 dark:text-amber-400">
              {inProgressCount}
            </p>
            <p className="text-[11px] text-slate-500 mt-0.5 font-medium">In Action</p>
          </div>
          <div className="px-2">
            <p className="text-xl sm:text-2xl font-extrabold text-emerald-600 dark:text-emerald-400">
              {resolvedCount}
            </p>
            <p className="text-[11px] text-slate-500 mt-0.5 font-medium">Resolved</p>
          </div>
        </div>
      </div>

      {/* Tourism & Heritage Banner */}
      <div
        onClick={() => onNavigate('tourism')}
        className="cursor-pointer rounded-3xl bg-linear-to-r from-[#00695C] to-[#00897B] text-white p-5 flex items-center justify-between shadow-xs hover:shadow-md transition-all"
      >
        <div className="space-y-1">
          <div className="flex items-center gap-1.5 text-teal-200 text-xs font-bold">
            <Compass className="w-4 h-4" />
            <span>Explore Kanyakumari</span>
          </div>
          <h4 className="text-base font-bold">Vivekananda Rock, Thiruvalluvar Statue & More</h4>
          <p className="text-xs text-teal-100 max-w-sm">
            Visit world-famous heritage monuments, palaces and waterfalls in the district.
          </p>
        </div>
        <ArrowRight className="w-5 h-5 text-teal-200 shrink-0 ml-3" />
      </div>

      {/* Recent Complaints Section */}
      <div className="space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div>
            <h3 className="text-base font-bold text-slate-900 dark:text-white">
              {language === 'ta' ? 'சமீபத்திய புகார்கள்' : 'Recent Civic Reports'}
            </h3>
            <p className="text-xs text-slate-500">
              Live updates across Nagercoil, Thuckalay, Colachel & Kanyakumari
            </p>
          </div>

          {/* Filter Tabs */}
          <div className="flex items-center gap-1.5 bg-slate-100 dark:bg-slate-800/80 p-1 rounded-xl text-xs font-semibold self-start sm:self-auto">
            <button
              type="button"
              onClick={() => setFilter('all')}
              className={`py-1 px-3 rounded-lg transition-colors ${
                filter === 'all'
                  ? 'bg-white dark:bg-[#1E1E1E] text-[#00695C] dark:text-[#00897B] shadow-xs'
                  : 'text-slate-600 dark:text-slate-400'
              }`}
            >
              All ({complaints.length})
            </button>
            <button
              type="button"
              onClick={() => setFilter('inProgress')}
              className={`py-1 px-3 rounded-lg transition-colors ${
                filter === 'inProgress'
                  ? 'bg-white dark:bg-[#1E1E1E] text-amber-600 shadow-xs'
                  : 'text-slate-600 dark:text-slate-400'
              }`}
            >
              Active ({inProgressCount})
            </button>
            <button
              type="button"
              onClick={() => setFilter('resolved')}
              className={`py-1 px-3 rounded-lg transition-colors ${
                filter === 'resolved'
                  ? 'bg-white dark:bg-[#1E1E1E] text-emerald-600 shadow-xs'
                  : 'text-slate-600 dark:text-slate-400'
              }`}
            >
              Resolved ({resolvedCount})
            </button>
          </div>
        </div>

        {/* Complaints Grid */}
        {filteredComplaints.length === 0 ? (
          <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-8 text-center border border-slate-200 dark:border-slate-800 space-y-3">
            <div className="w-12 h-12 rounded-full bg-slate-100 dark:bg-slate-800 mx-auto flex items-center justify-center text-slate-400">
              <ClipboardList className="w-6 h-6" />
            </div>
            <p className="text-sm font-semibold text-slate-700 dark:text-slate-300">
              No civic reports found
            </p>
            <button
              type="button"
              onClick={() => onNavigate('report_complaint')}
              className="py-2 px-4 rounded-xl bg-[#00695C] text-white text-xs font-medium"
            >
              File First Complaint
            </button>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {filteredComplaints.slice(0, 4).map((item) => (
              <ComplaintCard
                key={item.complaintId}
                complaint={item}
                onViewDetails={onViewDetails}
              />
            ))}
          </div>
        )}

        {filteredComplaints.length > 4 && (
          <div className="text-center pt-2">
            <button
              type="button"
              onClick={() => onNavigate('complaint_history')}
              className="inline-flex items-center gap-2 py-2.5 px-5 rounded-xl border border-slate-300 dark:border-slate-700 text-xs font-semibold text-slate-700 dark:text-slate-200 hover:bg-white dark:hover:bg-slate-800 transition-colors"
            >
              <span>View All Complaints</span>
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
