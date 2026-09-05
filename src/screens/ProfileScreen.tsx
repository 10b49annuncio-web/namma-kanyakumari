import React, { useState } from 'react';
import { ScreenRoute, UserModel } from '../types';
import { StorageService } from '../services/storage';
import { KANYAKUMARI_TALUKS } from '../constants/data';
import {
  User,
  Mail,
  Phone,
  MapPin,
  Moon,
  Sun,
  Globe,
  LogOut,
  Edit2,
  ShieldCheck,
  CheckCircle2,
  Info,
  Building,
  HeartHandshake
} from 'lucide-react';

interface ProfileScreenProps {
  user: UserModel | null;
  onUserUpdate: (updated: UserModel) => void;
  onNavigate: (route: ScreenRoute) => void;
  onLogout: () => void;
  darkMode: boolean;
  onToggleDarkMode: () => void;
  language: 'en' | 'ta';
  onToggleLanguage: () => void;
}

export const ProfileScreen: React.FC<ProfileScreenProps> = ({
  user,
  onUserUpdate,
  onNavigate,
  onLogout,
  darkMode,
  onToggleDarkMode,
  language,
  onToggleLanguage,
}) => {
  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState(user?.fullName || 'Karthik Raja');
  const [phone, setPhone] = useState(user?.phoneNumber || '9842145678');
  const [taluk, setTaluk] = useState(user?.taluk || KANYAKUMARI_TALUKS[0]);
  const [village, setVillage] = useState(user?.village || 'Nagercoil Town');
  const [pincode, setPincode] = useState(user?.pincode || '629001');

  const handleSaveProfile = (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    const updated: UserModel = {
      ...user,
      fullName: name.trim(),
      phoneNumber: phone.trim(),
      taluk,
      village: village.trim(),
      pincode: pincode.trim(),
      updatedAt: new Date().toISOString(),
    };

    StorageService.setCurrentUser(updated);
    onUserUpdate(updated);
    setIsEditing(false);
  };

  return (
    <div id="profile-screen" className="max-w-2xl mx-auto space-y-6 pb-24 pt-2 animate-fade-in">
      {/* Citizen Card Header */}
      <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 border border-slate-200 dark:border-slate-800 shadow-xs space-y-5">
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 rounded-2xl bg-[#00695C] text-white flex items-center justify-center font-bold text-2xl shadow-sm">
              {user?.fullName ? user.fullName.charAt(0).toUpperCase() : 'C'}
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h2 className="text-lg sm:text-xl font-bold text-slate-900 dark:text-white">
                  {user?.fullName || 'Citizen User'}
                </h2>
                <span className="text-[11px] font-bold text-[#00695C] dark:text-teal-300 bg-teal-50 dark:bg-teal-950/50 px-2.5 py-0.5 rounded-full flex items-center gap-1">
                  <ShieldCheck className="w-3.5 h-3.5" />
                  Verified Citizen
                </span>
              </div>
              <p className="text-xs text-slate-500 dark:text-slate-400 mt-0.5">
                {user?.email || 'citizen@kanyakumari.gov.in'}
              </p>
              <p className="text-xs text-[#00695C] dark:text-[#00897B] font-semibold mt-1">
                Kanyakumari District • {user?.taluk || 'Agastheeswaram'}
              </p>
            </div>
          </div>

          <button
            id="btn-edit-profile-toggle"
            type="button"
            onClick={() => setIsEditing(!isEditing)}
            className="p-2 rounded-xl text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
            title="Edit Profile"
          >
            <Edit2 className="w-4 h-4" />
          </button>
        </div>

        {/* Citizen Contact Details */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 pt-2 border-t border-slate-100 dark:border-slate-800 text-xs text-slate-700 dark:text-slate-300">
          <div className="flex items-center gap-2">
            <Phone className="w-3.5 h-3.5 text-[#00695C] shrink-0" />
            <span>+91 {user?.phoneNumber || '9842145678'}</span>
          </div>
          <div className="flex items-center gap-2">
            <MapPin className="w-3.5 h-3.5 text-red-500 shrink-0" />
            <span>{user?.village || 'Nagercoil'}, Pincode: {user?.pincode || '629001'}</span>
          </div>
        </div>
      </div>

      {/* Edit Profile Form (if active) */}
      {isEditing && (
        <form onSubmit={handleSaveProfile} className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 border border-[#00695C] shadow-sm space-y-4 animate-fade-in">
          <h3 className="text-sm font-bold text-slate-900 dark:text-white">
            Update Citizen Details
          </h3>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Full Name
              </label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white"
                required
              />
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Mobile Number
              </label>
              <input
                type="tel"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white"
                required
              />
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Taluk
              </label>
              <select
                value={taluk}
                onChange={(e) => setTaluk(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white"
              >
                {KANYAKUMARI_TALUKS.map((t) => (
                  <option key={t} value={t}>
                    {t}
                  </option>
                ))}
              </select>
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Town / Village & Pincode
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  value={village}
                  onChange={(e) => setVillage(e.target.value)}
                  placeholder="Village"
                  className="w-2/3 px-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white"
                />
                <input
                  type="text"
                  value={pincode}
                  onChange={(e) => setPincode(e.target.value)}
                  placeholder="Pincode"
                  className="w-1/3 px-3 py-2 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white"
                />
              </div>
            </div>
          </div>

          <div className="flex items-center gap-2 pt-2">
            <button
              id="btn-save-profile"
              type="submit"
              className="py-2 px-4 rounded-xl bg-[#00695C] text-white text-xs font-semibold hover:bg-[#004D40]"
            >
              Save Changes
            </button>
            <button
              type="button"
              onClick={() => setIsEditing(false)}
              className="py-2 px-3 rounded-xl border border-slate-300 dark:border-slate-700 text-xs text-slate-600 dark:text-slate-300"
            >
              Cancel
            </button>
          </div>
        </form>
      )}

      {/* Preferences & Settings */}
      <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-5 border border-slate-200 dark:border-slate-800 shadow-xs space-y-3">
        <h3 className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
          Preferences & Language
        </h3>

        <div className="divide-y divide-slate-100 dark:divide-slate-800">
          {/* Language Switch */}
          <div className="py-3 flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Globe className="w-5 h-5 text-[#00695C] dark:text-[#00897B]" />
              <div>
                <p className="text-xs sm:text-sm font-semibold text-slate-900 dark:text-white">
                  Application Language
                </p>
                <p className="text-[11px] text-slate-500">
                  Switch between English and Tamil (தமிழ்)
                </p>
              </div>
            </div>
            <button
              id="profile-toggle-lang"
              type="button"
              onClick={onToggleLanguage}
              className="py-1.5 px-3 rounded-xl bg-teal-50 dark:bg-teal-950/50 text-[#00695C] dark:text-teal-300 text-xs font-bold"
            >
              {language === 'en' ? 'English (Switch to தமிழ்)' : 'தமிழ் (Switch to ENG)'}
            </button>
          </div>

          {/* Theme Switch */}
          <div className="py-3 flex items-center justify-between">
            <div className="flex items-center gap-3">
              {darkMode ? (
                <Sun className="w-5 h-5 text-amber-400" />
              ) : (
                <Moon className="w-5 h-5 text-slate-600" />
              )}
              <div>
                <p className="text-xs sm:text-sm font-semibold text-slate-900 dark:text-white">
                  Appearance Theme
                </p>
                <p className="text-[11px] text-slate-500">
                  {darkMode ? 'Dark Theme (Night mode)' : 'Light Theme (Clean standard)'}
                </p>
              </div>
            </div>
            <button
              id="profile-toggle-theme"
              type="button"
              onClick={onToggleDarkMode}
              className="py-1.5 px-3 rounded-xl bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-200 text-xs font-semibold"
            >
              {darkMode ? 'Switch to Light' : 'Switch to Dark'}
            </button>
          </div>
        </div>
      </div>

      {/* District Governance Info */}
      <div className="bg-teal-50/50 dark:bg-teal-950/20 rounded-3xl p-5 border border-teal-100 dark:border-teal-900/40 space-y-2 text-xs">
        <div className="flex items-center gap-2 text-[#00695C] dark:text-teal-300 font-bold">
          <Info className="w-4 h-4" />
          <span>About Namma Kanyakumari</span>
        </div>
        <p className="text-slate-600 dark:text-slate-300 leading-relaxed">
          Namma Kanyakumari is an official citizen grievance redressal initiative empowering residents of Kanyakumari district to directly participate in local governance, report road/water/light hazards, and access 24/7 public helplines.
        </p>
        <p className="text-[11px] text-slate-500 pt-1">
          Version 1.0.0 • Developed for Kanyakumari District Administration
        </p>
      </div>

      {/* Logout Action */}
      <div className="pt-2">
        <button
          id="btn-logout"
          type="button"
          onClick={onLogout}
          className="w-full py-3 px-4 rounded-2xl border border-red-200 dark:border-red-900/60 text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-950/30 text-xs sm:text-sm font-bold flex items-center justify-center gap-2 transition-colors"
        >
          <LogOut className="w-4 h-4" />
          <span>Sign Out of Citizen Account</span>
        </button>
      </div>
    </div>
  );
};
