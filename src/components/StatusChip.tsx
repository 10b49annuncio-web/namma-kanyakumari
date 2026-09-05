import React from 'react';
import { ComplaintStatus } from '../types';
import { Upload, CheckCircle2, FileText, Wrench, ShieldCheck, Lock, AlertCircle } from 'lucide-react';

interface StatusChipProps {
  status: ComplaintStatus | string;
  size?: 'sm' | 'md';
}

export const StatusChip: React.FC<StatusChipProps> = ({ status, size = 'md' }) => {
  const normalized = (status || '').toLowerCase();

  let label = 'Submitted';
  let colorClasses = 'bg-blue-50 text-blue-700 border-blue-200';
  let Icon = Upload;

  switch (normalized) {
    case 'submitted':
      label = 'Submitted';
      colorClasses = 'bg-blue-50 text-blue-700 border-blue-200';
      Icon = Upload;
      break;
    case 'verified':
      label = 'Verified';
      colorClasses = 'bg-teal-50 text-teal-700 border-teal-200';
      Icon = ShieldCheck;
      break;
    case 'assigned':
      label = 'Assigned';
      colorClasses = 'bg-amber-50 text-amber-700 border-amber-200';
      Icon = FileText;
      break;
    case 'inprogress':
    case 'in progress':
      label = 'In Progress';
      colorClasses = 'bg-orange-50 text-orange-700 border-orange-200';
      Icon = Wrench;
      break;
    case 'resolved':
      label = 'Resolved';
      colorClasses = 'bg-emerald-50 text-emerald-700 border-emerald-200';
      Icon = CheckCircle2;
      break;
    case 'closed':
      label = 'Closed';
      colorClasses = 'bg-slate-100 text-slate-700 border-slate-300';
      Icon = Lock;
      break;
    case 'rejected':
      label = 'Rejected';
      colorClasses = 'bg-red-50 text-red-700 border-red-200';
      Icon = AlertCircle;
      break;
  }

  const paddingClass = size === 'sm' ? 'px-2.5 py-0.5 text-xs' : 'px-3 py-1 text-xs sm:text-sm font-semibold';

  return (
    <span
      id={`status-chip-${normalized}`}
      className={`inline-flex items-center gap-1.5 rounded-full border ${paddingClass} ${colorClasses}`}
    >
      <Icon className={size === 'sm' ? 'w-3 h-3' : 'w-3.5 h-3.5'} />
      <span className="capitalize">{label}</span>
    </span>
  );
};
