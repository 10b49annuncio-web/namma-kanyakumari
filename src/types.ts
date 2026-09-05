export type ComplaintStatus =
  | 'submitted'
  | 'verified'
  | 'assigned'
  | 'inProgress'
  | 'resolved'
  | 'rejected'
  | 'closed';

export type ComplaintPriority = 'low' | 'medium' | 'high' | 'emergency';

export interface ComplaintModel {
  complaintId: string;
  userId: string;
  userName: string;
  phoneNumber: string;
  category: string;
  title: string;
  description: string;
  imageUrls: string[];
  latitude: number;
  longitude: number;
  address: string;
  status: ComplaintStatus;
  priority: ComplaintPriority;
  departmentId?: string;
  departmentName?: string;
  assignedOfficerId?: string;
  assignedOfficerName?: string;
  aiDetected: boolean;
  aiPrediction?: string;
  aiConfidence?: number;
  createdAt: string;
  updatedAt?: string;
  resolvedAt?: string;
  isPublic: boolean;
}

export type UserRole = 'citizen' | 'officer' | 'admin';

export interface UserModel {
  uid: string;
  fullName: string;
  email: string;
  phoneNumber: string;
  profileImage?: string;
  role: UserRole;
  isVerified: boolean;
  isActive: boolean;
  address?: string;
  district?: string;
  taluk?: string;
  village?: string;
  pincode?: string;
  createdAt: string;
  updatedAt?: string;
}

export type EmergencyType =
  | 'police'
  | 'ambulance'
  | 'fire'
  | 'disaster'
  | 'hospital'
  | 'women'
  | 'child'
  | 'electricity'
  | 'water'
  | 'traffic'
  | 'coastGuard'
  | 'other';

export interface EmergencyModel {
  id: string;
  name: string;
  description: string;
  type: EmergencyType;
  phoneNumber: string;
  alternatePhone?: string;
  address: string;
  latitude: number;
  longitude: number;
  icon: string;
  is24Hours: boolean;
  isActive: boolean;
}

export interface DepartmentModel {
  departmentId: string;
  name: string;
  description: string;
  icon: string;
  phoneNumber: string;
  email: string;
  officeAddress: string;
  isActive: boolean;
  totalOfficers: number;
  complaintCategories: string[];
}

export type NotificationType =
  | 'complaint'
  | 'emergency'
  | 'announcement'
  | 'news'
  | 'reminder'
  | 'system';

export interface NotificationModel {
  notificationId: string;
  userId: string;
  title: string;
  body: string;
  type: NotificationType;
  imageUrl?: string;
  complaintId?: string;
  isRead: boolean;
  createdAt: string;
}

export interface TourismPlace {
  id: string;
  name: string;
  tamilName: string;
  tagline: string;
  description: string;
  location: string;
  timing: string;
  entryFee: string;
  imageUrl: string;
  highlights: string[];
}

export interface GovernmentOffice {
  id: string;
  name: string;
  department: string;
  officerInCharge: string;
  phone: string;
  email: string;
  address: string;
  services: string[];
}

export type ScreenRoute =
  | 'splash'
  | 'onboarding'
  | 'login'
  | 'signup'
  | 'forgot_password'
  | 'home'
  | 'report_complaint'
  | 'complaint_history'
  | 'complaint_details'
  | 'emergency'
  | 'government_services'
  | 'tourism'
  | 'notifications'
  | 'profile'
  | 'settings';
