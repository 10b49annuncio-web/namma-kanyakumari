import { ComplaintModel, UserModel, NotificationModel } from '../types';
import { INITIAL_COMPLAINTS, DEMO_USER, NOTIFICATIONS } from '../constants/data';

const STORAGE_KEYS = {
  FIRST_TIME: 'nk_first_time',
  CURRENT_USER: 'nk_current_user',
  COMPLAINTS: 'nk_complaints',
  NOTIFICATIONS: 'nk_notifications',
  DARK_MODE: 'nk_dark_mode',
  LANGUAGE: 'nk_language',
};

export const StorageService = {
  isFirstTime(): boolean {
    const val = localStorage.getItem(STORAGE_KEYS.FIRST_TIME);
    return val === null ? true : val === 'true';
  },

  setFirstTime(firstTime: boolean): void {
    localStorage.setItem(STORAGE_KEYS.FIRST_TIME, firstTime.toString());
  },

  getCurrentUser(): UserModel | null {
    const userStr = localStorage.getItem(STORAGE_KEYS.CURRENT_USER);
    if (!userStr) return DEMO_USER;
    try {
      return JSON.parse(userStr);
    } catch {
      return DEMO_USER;
    }
  },

  setCurrentUser(user: UserModel | null): void {
    if (user) {
      localStorage.setItem(STORAGE_KEYS.CURRENT_USER, JSON.stringify(user));
    } else {
      localStorage.removeItem(STORAGE_KEYS.CURRENT_USER);
    }
  },

  getComplaints(): ComplaintModel[] {
    const stored = localStorage.getItem(STORAGE_KEYS.COMPLAINTS);
    if (!stored) {
      localStorage.setItem(STORAGE_KEYS.COMPLAINTS, JSON.stringify(INITIAL_COMPLAINTS));
      return INITIAL_COMPLAINTS;
    }
    try {
      return JSON.parse(stored);
    } catch {
      return INITIAL_COMPLAINTS;
    }
  },

  saveComplaint(complaint: ComplaintModel): ComplaintModel[] {
    const all = this.getComplaints();
    const updated = [complaint, ...all];
    localStorage.setItem(STORAGE_KEYS.COMPLAINTS, JSON.stringify(updated));

    // Also add a system notification for the complaint
    const newNotif: NotificationModel = {
      notificationId: `notif_${Date.now()}`,
      userId: complaint.userId,
      title: `Complaint Logged: ${complaint.complaintId}`,
      body: `Your issue regarding "${complaint.category}" in ${complaint.address.split(',')[0]} has been registered and sent for verification.`,
      type: 'complaint',
      complaintId: complaint.complaintId,
      isRead: false,
      createdAt: new Date().toISOString(),
    };
    this.saveNotification(newNotif);

    return updated;
  },

  updateComplaintStatus(complaintId: string, newStatus: ComplaintModel['status']): ComplaintModel[] {
    const all = this.getComplaints();
    const updated = all.map(c => {
      if (c.complaintId === complaintId) {
        return {
          ...c,
          status: newStatus,
          updatedAt: new Date().toISOString(),
          resolvedAt: newStatus === 'resolved' ? new Date().toISOString() : c.resolvedAt,
        };
      }
      return c;
    });
    localStorage.setItem(STORAGE_KEYS.COMPLAINTS, JSON.stringify(updated));
    return updated;
  },

  getNotifications(): NotificationModel[] {
    const stored = localStorage.getItem(STORAGE_KEYS.NOTIFICATIONS);
    if (!stored) {
      localStorage.setItem(STORAGE_KEYS.NOTIFICATIONS, JSON.stringify(NOTIFICATIONS));
      return NOTIFICATIONS;
    }
    try {
      return JSON.parse(stored);
    } catch {
      return NOTIFICATIONS;
    }
  },

  saveNotification(notification: NotificationModel): void {
    const all = this.getNotifications();
    const updated = [notification, ...all];
    localStorage.setItem(STORAGE_KEYS.NOTIFICATIONS, JSON.stringify(updated));
  },

  markNotificationRead(id: string): NotificationModel[] {
    const all = this.getNotifications();
    const updated = all.map(n => n.notificationId === id ? { ...n, isRead: true } : n);
    localStorage.setItem(STORAGE_KEYS.NOTIFICATIONS, JSON.stringify(updated));
    return updated;
  },

  markAllNotificationsRead(): NotificationModel[] {
    const all = this.getNotifications();
    const updated = all.map(n => ({ ...n, isRead: true }));
    localStorage.setItem(STORAGE_KEYS.NOTIFICATIONS, JSON.stringify(updated));
    return updated;
  },

  isDarkMode(): boolean {
    const val = localStorage.getItem(STORAGE_KEYS.DARK_MODE);
    return val === 'true';
  },

  setDarkMode(dark: boolean): void {
    localStorage.setItem(STORAGE_KEYS.DARK_MODE, dark.toString());
  },

  getLanguage(): 'en' | 'ta' {
    const val = localStorage.getItem(STORAGE_KEYS.LANGUAGE);
    return (val === 'ta' ? 'ta' : 'en');
  },

  setLanguage(lang: 'en' | 'ta'): void {
    localStorage.setItem(STORAGE_KEYS.LANGUAGE, lang);
  }
};
