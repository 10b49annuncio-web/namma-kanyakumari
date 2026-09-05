import React from 'react';
import { ScreenRoute } from '../types';
import { Home, PlusCircle, ClipboardList, ShieldAlert, User } from 'lucide-react';

interface BottomNavProps {
  currentScreen: ScreenRoute;
  onNavigate: (route: ScreenRoute) => void;
  language: 'en' | 'ta';
}

export const BottomNav: React.FC<BottomNavProps> = ({ currentScreen, onNavigate, language }) => {
  const tabs = [
    {
      id: 'home' as ScreenRoute,
      label: language === 'ta' ? 'முகப்பு' : 'Home',
      icon: Home,
    },
    {
      id: 'complaint_history' as ScreenRoute,
      label: language === 'ta' ? 'புகார்கள்' : 'Complaints',
      icon: ClipboardList,
    },
    {
      id: 'report_complaint' as ScreenRoute,
      label: language === 'ta' ? 'பதிவு' : 'Report',
      icon: PlusCircle,
      isPrimary: true,
    },
    {
      id: 'emergency' as ScreenRoute,
      label: language === 'ta' ? 'அவசரம்' : 'Emergency',
      icon: ShieldAlert,
    },
    {
      id: 'profile' as ScreenRoute,
      label: language === 'ta' ? 'சுயவிவரம்' : 'Profile',
      icon: User,
    },
  ];

  return (
    <nav
      id="bottom-navigation"
      className="fixed bottom-0 left-0 right-0 z-40 bg-white/95 dark:bg-[#1E1E1E]/95 backdrop-blur-md border-t border-slate-200 dark:border-slate-800 shadow-lg"
    >
      <div className="max-w-md mx-auto px-4 h-16 flex items-center justify-around">
        {tabs.map((tab) => {
          const isActive = currentScreen === tab.id;
          const Icon = tab.icon;

          if (tab.isPrimary) {
            return (
              <button
                key={tab.id}
                id={`tab-${tab.id}`}
                type="button"
                onClick={() => onNavigate(tab.id)}
                className="flex flex-col items-center -mt-5 focus:outline-none"
              >
                <div className="w-12 h-12 rounded-full bg-[#00695C] text-white flex items-center justify-center shadow-md hover:bg-[#004D40] transition-transform active:scale-95">
                  <Icon className="w-6 h-6" />
                </div>
                <span className={`text-[10px] font-semibold mt-1 ${isActive ? 'text-[#00695C] dark:text-[#00897B]' : 'text-slate-600 dark:text-slate-400'}`}>
                  {tab.label}
                </span>
              </button>
            );
          }

          return (
            <button
              key={tab.id}
              id={`tab-${tab.id}`}
              type="button"
              onClick={() => onNavigate(tab.id)}
              className={`flex flex-col items-center justify-center py-1 px-2 rounded-xl transition-colors focus:outline-none ${
                isActive
                  ? 'text-[#00695C] dark:text-[#00897B] font-semibold'
                  : 'text-slate-500 dark:text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
              }`}
            >
              <Icon className={`w-5 h-5 ${isActive ? 'stroke-[2.5]' : 'stroke-2'}`} />
              <span className="text-[10px] tracking-tight mt-0.5">{tab.label}</span>
            </button>
          );
        })}
      </div>
    </nav>
  );
};
