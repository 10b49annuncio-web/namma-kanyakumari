import React from 'react';
import { ComplaintModel, ComplaintStatus } from '../types';
import { StatusChip } from './StatusChip';
import { X, MapPin, Calendar, CheckCircle2, User, Building, Sparkles, Phone, Tag } from 'lucide-react';

interface ComplaintDetailModalProps {
  complaint: ComplaintModel | null;
  onClose: () => void;
  onStatusChange: (complaintId: string, newStatus: ComplaintStatus) => void;
}

export const ComplaintDetailModal: React.FC<ComplaintDetailModalProps> = ({
  complaint,
  onClose,
  onStatusChange,
}) => {
  if (!complaint) return null;

  const steps: { key: ComplaintStatus; label: string; desc: string }[] = [
    { key: 'submitted', label: 'Submitted', desc: 'Complaint registered by citizen' },
    { key: 'verified', label: 'Verified', desc: 'Civic field validation complete' },
    { key: 'assigned', label: 'Assigned', desc: 'Officer appointed for resolution' },
    { key: 'inProgress', label: 'In Progress', desc: 'Field team active on site' },
    { key: 'resolved', label: 'Resolved', desc: 'Work inspected and closed' },
  ];

  const statusOrder: ComplaintStatus[] = ['submitted', 'verified', 'assigned', 'inProgress', 'resolved'];
  const currentIndex = statusOrder.indexOf(complaint.status);

  return (
    <div
      id="complaint-detail-modal"
      className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-3 sm:p-4 overflow-y-auto animate-fade-in"
    >
      <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl max-w-xl w-full max-h-[90vh] overflow-y-auto border border-slate-200 dark:border-slate-800 shadow-2xl relative my-auto">
        {/* Sticky Header */}
        <div className="sticky top-0 z-10 bg-white/95 dark:bg-[#1E1E1E]/95 backdrop-blur-md px-5 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="text-xs font-mono font-bold text-[#00695C] bg-teal-50 dark:bg-teal-950/50 px-2.5 py-1 rounded-lg">
              {complaint.complaintId}
            </span>
            <StatusChip status={complaint.status} size="sm" />
          </div>
          <button
            id="btn-close-detail-modal"
            type="button"
            onClick={onClose}
            className="p-1.5 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 dark:text-slate-400 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Content Body */}
        <div className="p-5 sm:p-6 space-y-6">
          {/* Main Photo Banner */}
          <div className="relative rounded-2xl overflow-hidden h-52 sm:h-64 bg-slate-100 dark:bg-slate-800">
            <img
              src={complaint.imageUrls[0] || 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&w=800&q=80'}
              alt={complaint.title}
              className="w-full h-full object-cover"
            />
            {complaint.aiDetected && (
              <div className="absolute top-3 left-3 bg-[#004D40]/90 backdrop-blur-md text-white text-xs px-3 py-1.5 rounded-full flex items-center gap-1.5 shadow-md">
                <Sparkles className="w-3.5 h-3.5 text-teal-300" />
                <span>AI Detected: {complaint.aiPrediction} ({Math.round((complaint.aiConfidence || 0.9) * 100)}% match)</span>
              </div>
            )}
          </div>

          {/* Title & Description */}
          <div>
            <div className="flex items-center gap-2 text-xs font-medium text-[#00695C] dark:text-[#00897B] mb-1">
              <Tag className="w-3.5 h-3.5" />
              <span>{complaint.category}</span>
              <span>•</span>
              <span className="capitalize font-semibold text-amber-600 dark:text-amber-400">
                {complaint.priority} Priority
              </span>
            </div>
            <h2 className="text-xl font-bold text-slate-900 dark:text-white leading-snug">
              {complaint.title}
            </h2>
            <p className="text-slate-600 dark:text-slate-300 text-sm mt-2 leading-relaxed">
              {complaint.description}
            </p>
          </div>

          {/* Location & Reported Info */}
          <div className="bg-slate-50 dark:bg-slate-800/50 rounded-2xl p-4 border border-slate-100 dark:border-slate-800 space-y-2.5 text-xs sm:text-sm">
            <div className="flex items-start gap-2 text-slate-700 dark:text-slate-300">
              <MapPin className="w-4 h-4 text-red-500 shrink-0 mt-0.5" />
              <span>{complaint.address}</span>
            </div>
            <div className="flex items-center gap-2 text-slate-600 dark:text-slate-400">
              <Calendar className="w-4 h-4 text-[#00695C] shrink-0" />
              <span>Reported on: {new Date(complaint.createdAt).toLocaleString('en-IN')}</span>
            </div>
            <div className="flex items-center gap-2 text-slate-600 dark:text-slate-400">
              <User className="w-4 h-4 text-slate-500 shrink-0" />
              <span>Reported by: {complaint.userName} (+91 {complaint.phoneNumber})</span>
            </div>
          </div>

          {/* Officer & Department Info */}
          {(complaint.departmentName || complaint.assignedOfficerName) && (
            <div className="bg-teal-50/50 dark:bg-teal-950/30 rounded-2xl p-4 border border-teal-100 dark:border-teal-900/50 space-y-2">
              <h4 className="text-xs font-bold uppercase tracking-wider text-[#00695C] dark:text-teal-300 flex items-center gap-1.5">
                <Building className="w-3.5 h-3.5" />
                Assigned Civic Authority
              </h4>
              {complaint.departmentName && (
                <p className="text-xs sm:text-sm font-semibold text-slate-800 dark:text-white">
                  {complaint.departmentName}
                </p>
              )}
              {complaint.assignedOfficerName && (
                <div className="flex items-center justify-between text-xs text-slate-600 dark:text-slate-300">
                  <span className="flex items-center gap-1">
                    <User className="w-3.5 h-3.5 text-[#00695C]" />
                    {complaint.assignedOfficerName}
                  </span>
                  <span className="text-[#00695C] font-mono text-[11px] bg-teal-100/60 dark:bg-teal-900/60 px-2 py-0.5 rounded">
                    ID: {complaint.assignedOfficerId || 'KK-OFF'}
                  </span>
                </div>
              )}
            </div>
          )}

          {/* Progress Timeline Stepper */}
          <div className="space-y-3 pt-2">
            <h4 className="text-sm font-bold text-slate-900 dark:text-white flex items-center gap-2">
              <CheckCircle2 className="w-4 h-4 text-[#00695C]" />
              Redressal Lifecycle
            </h4>

            <div className="relative pl-6 space-y-6 before:content-[''] before:absolute before:left-2.5 before:top-2 before:bottom-2 before:w-0.5 before:bg-slate-200 dark:before:bg-slate-700">
              {steps.map((step, idx) => {
                const isPassed = currentIndex >= idx;
                const isCurrent = currentIndex === idx;

                return (
                  <div key={step.key} className="relative">
                    <div
                      className={`absolute -left-6 top-0.5 w-5 h-5 rounded-full border-2 flex items-center justify-center text-[10px] ${
                        isPassed
                          ? 'bg-[#00695C] border-[#00695C] text-white'
                          : 'bg-white dark:bg-[#1E1E1E] border-slate-300 dark:border-slate-600 text-slate-400'
                      }`}
                    >
                      {isPassed ? '✓' : idx + 1}
                    </div>
                    <div>
                      <p className={`text-sm font-semibold ${isCurrent ? 'text-[#00695C] dark:text-[#00897B]' : isPassed ? 'text-slate-800 dark:text-slate-200' : 'text-slate-400'}`}>
                        {step.label}
                      </p>
                      <p className="text-xs text-slate-500 dark:text-slate-400">
                        {step.desc}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>

          {/* Interactive Officer / Demo Status Switcher */}
          <div className="p-4 rounded-2xl bg-slate-100 dark:bg-slate-800/80 border border-slate-200 dark:border-slate-700 space-y-2.5">
            <div className="flex items-center justify-between">
              <label htmlFor="status-select" className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Update Status (Field Redressal Simulation):
              </label>
            </div>
            <div className="grid grid-cols-3 gap-2">
              {(['submitted', 'verified', 'assigned', 'inProgress', 'resolved', 'closed'] as ComplaintStatus[]).map((st) => (
                <button
                  key={st}
                  id={`btn-set-status-${st}`}
                  type="button"
                  onClick={() => onStatusChange(complaint.complaintId, st)}
                  className={`py-1.5 px-2 rounded-xl text-xs font-medium capitalize border transition-all ${
                    complaint.status === st
                      ? 'bg-[#00695C] text-white border-[#00695C] shadow-xs'
                      : 'bg-white dark:bg-[#2A2A2A] text-slate-700 dark:text-slate-300 border-slate-200 dark:border-slate-700 hover:border-[#00695C]'
                  }`}
                >
                  {st}
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
