import React from 'react';
import { ScreenRoute, UserModel } from '../types';
import { Bell, ShieldAlert, Moon, Sun, ArrowLeft, Globe } from 'lucide-react';

interface NavbarProps {
  currentScreen: ScreenRoute;
  onNavigate: (route: ScreenRoute) => void;
  user: UserModel | null;
  unreadCount: number;
  darkMode: boolean;
  onToggleDarkMode: () => void;
  language: 'en' | 'ta';
  onToggleLanguage: () => void;
}

export const Navbar: React.FC<NavbarProps> = ({
  currentScreen,
  onNavigate,
  user,
  unreadCount,
  darkMode,
  onToggleDarkMode,
  language,
  onToggleLanguage,
}) => {
  const isDetailScreen = [
    'report_complaint',
    'complaint_history',
    'emergency',
    'government_services',
    'tourism',
    'notifications',
    'profile',
    'settings',
  ].includes(currentScreen);

  const getScreenTitle = () => {
    switch (currentScreen) {
      case 'report_complaint':
        return language === 'ta' ? 'புகார் பதிவு செய்க' : 'Report Civic Issue';
      case 'complaint_history':
        return language === 'ta' ? 'என் புகார்கள்' : 'Complaint History';
      case 'emergency':
        return language === 'ta' ? 'அவசர உதவிகள்' : 'Emergency Services';
      case 'government_services':
        return language === 'ta' ? 'அரசு சேவைகள்' : 'Government Services';
      case 'tourism':
        return language === 'ta' ? 'கன்னியாகுமரி சுற்றுலா' : 'District Tourism';
      case 'notifications':
        return language === 'ta' ? 'அறிவிப்புகள்' : 'Notifications';
      case 'profile':
        return language === 'ta' ? 'சுயவிவரம்' : 'Citizen Profile';
      case 'settings':
        return language === 'ta' ? 'அமைப்புகள்' : 'Settings';
      default:
        return 'Namma Kanyakumari';
    }
  };

  return (
    <header
      id="app-header"
      className="sticky top-0 z-40 bg-white/95 dark:bg-[#1E1E1E]/95 backdrop-blur-md border-b border-slate-200 dark:border-slate-800 transition-colors shadow-xs"
    >
      <div className="max-w-4xl mx-auto px-4 sm:px-6 h-16 flex items-center justify-between">
        {/* Left Side */}
        <div className="flex items-center gap-3">
          {isDetailScreen ? (
            <button
              id="nav-back-button"
              type="button"
              onClick={() => onNavigate('home')}
              className="p-2 -ml-2 rounded-xl text-slate-700 dark:text-slate-200 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
              aria-label="Back to home"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
          ) : (
            <div className="w-10 h-10 rounded-xl bg-[#00695C] p-1.5 flex items-center justify-center shadow-xs overflow-hidden shrink-0">
              <img
                src="/assets/logo/app_icon.png"
                alt="App Icon"
                className="w-full h-full object-contain"
                onError={(e) => {
                  (e.target as HTMLImageElement).src = '/assets/logo/app_logo.png';
                }}
              />
            </div>
          )}

          <div>
            <h1 className="text-base sm:text-lg font-bold text-slate-900 dark:text-white leading-tight flex items-center gap-1.5">
              <span>{getScreenTitle()}</span>
            </h1>
            {!isDetailScreen && (
              <p className="text-[11px] font-medium text-[#00695C] dark:text-[#00897B] tracking-wide">
                {language === 'ta' ? 'உங்கள் குரல். உங்கள் மாவட்டம்.' : 'Your Voice. Your District.'}
              </p>
            )}
          </div>
        </div>

        {/* Right Actions */}
        <div className="flex items-center gap-1.5 sm:gap-2">
          {/* Language Toggle */}
          <button
            id="nav-lang-btn"
            type="button"
            onClick={onToggleLanguage}
            title={language === 'en' ? 'Switch to Tamil' : 'Switch to English'}
            className="flex items-center gap-1 px-2.5 py-1.5 rounded-xl text-xs font-semibold text-[#00695C] dark:text-teal-300 bg-teal-50 dark:bg-teal-950/50 hover:bg-teal-100 dark:hover:bg-teal-900/50 transition-colors"
          >
            <Globe className="w-3.5 h-3.5" />
            <span>{language === 'en' ? 'தமிழ்' : 'ENG'}</span>
          </button>

          {/* Dark Mode Toggle */}
          <button
            id="nav-theme-btn"
            type="button"
            onClick={onToggleDarkMode}
            className="p-2 rounded-xl text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
            aria-label="Toggle theme"
          >
            {darkMode ? <Sun className="w-4 h-4 text-amber-400" /> : <Moon className="w-4 h-4 text-slate-600" />}
          </button>

          {/* Emergency SOS Button */}
          <button
            id="nav-emergency-btn"
            type="button"
            onClick={() => onNavigate('emergency')}
            className="p-2 rounded-xl bg-red-50 dark:bg-red-950/40 text-red-600 dark:text-red-400 hover:bg-red-100 transition-colors"
            title="Emergency SOS"
          >
            <ShieldAlert className="w-4 h-4" />
          </button>

          {/* Notifications */}
          <button
            id="nav-notifications-btn"
            type="button"
            onClick={() => onNavigate('notifications')}
            className="relative p-2 rounded-xl text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
            aria-label="Notifications"
          >
            <Bell className="w-4 h-4" />
            {unreadCount > 0 && (
              <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-red-500 ring-2 ring-white dark:ring-[#1E1E1E]" />
            )}
          </button>
        </div>
      </div>
    </header>
  );
};
