import React from 'react';
import { ComplaintModel } from '../types';
import { StatusChip } from './StatusChip';
import { MapPin, Calendar, Tag, ArrowRight, Eye, Sparkles } from 'lucide-react';

interface ComplaintCardProps {
  complaint: ComplaintModel;
  onViewDetails: (complaint: ComplaintModel) => void;
}

export const ComplaintCard: React.FC<ComplaintCardProps> = ({ complaint, onViewDetails }) => {
  const formattedDate = new Date(complaint.createdAt).toLocaleDateString('en-IN', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  });

  const displayImage = complaint.imageUrls?.[0] || 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&w=800&q=80';

  return (
    <div
      id={`complaint-card-${complaint.complaintId}`}
      className="bg-white dark:bg-[#1E1E1E] rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:shadow-md transition-all overflow-hidden flex flex-col"
    >
      {/* Thumbnail Banner */}
      <div className="relative h-44 w-full overflow-hidden bg-slate-100 dark:bg-slate-800">
        <img
          src={displayImage}
          alt={complaint.title}
          className="w-full h-full object-cover"
          onError={(e) => {
            (e.target as HTMLImageElement).src = 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80';
          }}
        />
        <div className="absolute top-3 right-3">
          <StatusChip status={complaint.status} />
        </div>
        {complaint.aiDetected && (
          <div className="absolute bottom-3 left-3 bg-[#004D40]/90 backdrop-blur-md text-white text-xs px-2.5 py-1 rounded-full flex items-center gap-1.5 shadow-sm">
            <Sparkles className="w-3 h-3 text-teal-300" />
            <span>AI Verified</span>
          </div>
        )}
      </div>

      {/* Card Content */}
      <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between space-y-3">
        <div>
          <div className="flex items-center justify-between text-xs text-slate-500 dark:text-slate-400 mb-1.5">
            <span className="font-mono font-semibold text-[#00695C] dark:text-[#00897B] flex items-center gap-1">
              <Tag className="w-3.5 h-3.5" />
              {complaint.complaintId}
            </span>
            <span className="flex items-center gap-1">
              <Calendar className="w-3.5 h-3.5" />
              {formattedDate}
            </span>
          </div>

          <h3 className="font-semibold text-slate-900 dark:text-white text-base leading-snug line-clamp-1">
            {complaint.title || complaint.category}
          </h3>

          <p className="text-slate-600 dark:text-slate-300 text-xs sm:text-sm mt-1 line-clamp-2 leading-relaxed">
            {complaint.description}
          </p>
        </div>

        <div className="pt-2 border-t border-slate-100 dark:border-slate-800 space-y-2.5">
          <div className="flex items-start gap-1.5 text-xs text-slate-600 dark:text-slate-400">
            <MapPin className="w-3.5 h-3.5 text-red-500 shrink-0 mt-0.5" />
            <span className="line-clamp-1">{complaint.address}</span>
          </div>

          <button
            id={`btn-view-${complaint.complaintId}`}
            type="button"
            onClick={() => onViewDetails(complaint)}
            className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-xl bg-[#00695C] hover:bg-[#004D40] text-white text-xs sm:text-sm font-medium transition-colors shadow-sm"
          >
            <Eye className="w-4 h-4" />
            <span>View Details & Timeline</span>
            <ArrowRight className="w-3.5 h-3.5 ml-1" />
          </button>
        </div>
      </div>
    </div>
  );
};
