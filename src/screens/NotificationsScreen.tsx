import React from 'react';
import { NotificationModel, ScreenRoute, ComplaintModel } from '../types';
import { StorageService } from '../services/storage';
import { Bell, CheckCheck, AlertTriangle, ShieldCheck, Info, ArrowRight } from 'lucide-react';

interface NotificationsScreenProps {
  notifications: NotificationModel[];
  onNotificationsChange: (updated: NotificationModel[]) => void;
  complaints: ComplaintModel[];
  onViewDetails: (complaint: ComplaintModel) => void;
  language: 'en' | 'ta';
}

export const NotificationsScreen: React.FC<NotificationsScreenProps> = ({
  notifications,
  onNotificationsChange,
  complaints,
  onViewDetails,
  language,
}) => {
  const handleMarkAllRead = () => {
    const updated = StorageService.markAllNotificationsRead();
    onNotificationsChange(updated);
  };

  const handleItemClick = (notif: NotificationModel) => {
    if (!notif.isRead) {
      const updated = StorageService.markNotificationRead(notif.notificationId);
      onNotificationsChange(updated);
    }

    if (notif.complaintId) {
      const matched = complaints.find(c => c.complaintId === notif.complaintId);
      if (matched) {
        onViewDetails(matched);
      }
    }
  };

  const getIcon = (type: NotificationModel['type']) => {
    switch (type) {
      case 'emergency':
        return <AlertTriangle className="w-5 h-5 text-amber-500" />;
      case 'complaint':
        return <ShieldCheck className="w-5 h-5 text-[#00695C] dark:text-[#00897B]" />;
      default:
        return <Info className="w-5 h-5 text-blue-500" />;
    }
  };

  return (
    <div id="notifications-screen" className="max-w-2xl mx-auto space-y-4 pb-24 pt-2 animate-fade-in">
      {/* Header action */}
      <div className="flex items-center justify-between px-1">
        <div>
          <h2 className="text-base font-bold text-slate-900 dark:text-white">
            {language === 'ta' ? 'அறிவிப்புகள்' : 'Notifications'}
          </h2>
          <p className="text-xs text-slate-500">
            {language === 'ta' ? 'மாவட்ட முக்கிய தகவல்கள் மற்றும் நிலை மாற்றங்கள்' : 'District bulletins and complaint progress updates'}
          </p>
        </div>

        {notifications.some(n => !n.isRead) && (
          <button
            id="btn-mark-all-read"
            type="button"
            onClick={handleMarkAllRead}
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-[#00695C] dark:text-[#00897B] hover:underline"
          >
            <CheckCheck className="w-4 h-4" />
            <span>Mark all read</span>
          </button>
        )}
      </div>

      {/* Notifications List */}
      {notifications.length === 0 ? (
        <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-10 text-center border border-slate-200 dark:border-slate-800 space-y-3">
          <div className="w-12 h-12 rounded-full bg-slate-100 dark:bg-slate-800 mx-auto flex items-center justify-center text-slate-400">
            <Bell className="w-6 h-6" />
          </div>
          <p className="text-sm font-semibold text-slate-700 dark:text-slate-300">
            No notifications at the moment
          </p>
        </div>
      ) : (
        <div className="space-y-2.5">
          {notifications.map((notif) => (
            <div
              key={notif.notificationId}
              id={`notif-${notif.notificationId}`}
              onClick={() => handleItemClick(notif)}
              className={`p-4 rounded-2xl border transition-all cursor-pointer flex items-start gap-3.5 ${
                notif.isRead
                  ? 'bg-white dark:bg-[#1E1E1E] border-slate-200 dark:border-slate-800 opacity-80'
                  : 'bg-teal-50/50 dark:bg-teal-950/20 border-teal-200 dark:border-teal-900/60 shadow-xs'
              }`}
            >
              <div className="w-10 h-10 rounded-xl bg-white dark:bg-[#2A2A2A] border border-slate-200 dark:border-slate-700 flex items-center justify-center shrink-0 shadow-xs">
                {getIcon(notif.type)}
              </div>

              <div className="flex-1 min-w-0">
                <div className="flex items-center justify-between gap-2">
                  <h4 className="text-xs sm:text-sm font-bold text-slate-900 dark:text-white truncate">
                    {notif.title}
                  </h4>
                  {!notif.isRead && (
                    <span className="w-2 h-2 rounded-full bg-[#00695C] shrink-0" />
                  )}
                </div>

                <p className="text-xs text-slate-600 dark:text-slate-300 mt-1 leading-relaxed">
                  {notif.body}
                </p>

                <div className="mt-2 flex items-center justify-between text-[11px] text-slate-400">
                  <span>{new Date(notif.createdAt).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', hour: '2-digit', minute: '2-digit' })}</span>
                  {notif.complaintId && (
                    <span className="text-[#00695C] dark:text-[#00897B] font-semibold flex items-center gap-1">
                      View details <ArrowRight className="w-3 h-3" />
                    </span>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};
