import React, { useEffect } from 'react';
import { ScreenRoute } from '../types';
import { StorageService } from '../services/storage';
import { Loader2 } from 'lucide-react';

interface SplashScreenProps {
  onNavigate: (route: ScreenRoute) => void;
}

export const SplashScreen: React.FC<SplashScreenProps> = ({ onNavigate }) => {
  useEffect(() => {
    const timer = setTimeout(() => {
      const isFirst = StorageService.isFirstTime();
      if (isFirst) {
        onNavigate('onboarding');
      } else {
        const user = StorageService.getCurrentUser();
        onNavigate(user ? 'home' : 'login');
      }
    }, 2400);

    return () => clearTimeout(timer);
  }, [onNavigate]);

  return (
    <div
      id="splash-screen"
      className="min-h-screen bg-white dark:bg-[#121212] flex flex-col items-center justify-center p-6 text-center select-none"
    >
      <div className="flex flex-col items-center max-w-sm w-full animate-fade-in space-y-6">
        {/* Emblem / Logo */}
        <div className="w-32 h-32 sm:w-40 sm:h-40 rounded-3xl bg-teal-50 dark:bg-teal-950/40 p-4 shadow-sm flex items-center justify-center border border-teal-100 dark:border-teal-900/60">
          <img
            src="/assets/logo/splash_logo.png"
            alt="Namma Kanyakumari"
            className="w-full h-full object-contain"
            onError={(e) => {
              (e.target as HTMLImageElement).src = '/assets/logo/app_logo.png';
            }}
          />
        </div>

        {/* Branding Typography matching main.dart */}
        <div className="space-y-2">
          <h1 className="text-2xl sm:text-3xl font-extrabold text-[#00695C] dark:text-[#00897B] tracking-tight">
            Namma Kanyakumari
          </h1>
          <p className="text-sm sm:text-base font-medium text-slate-600 dark:text-slate-300">
            Your Voice. Your District.
          </p>
          <p className="text-xs text-[#2E7D32] dark:text-emerald-400 font-semibold tracking-wide">
            கன்னியாகுமரி மாவட்ட நிர்வாகம்
          </p>
        </div>

        {/* Loading Indicator */}
        <div className="pt-6 flex flex-col items-center gap-3">
          <Loader2 className="w-8 h-8 text-[#00695C] dark:text-[#00897B] animate-spin" />
          <span className="text-xs text-slate-600 dark:text-slate-400 font-medium">
            Connecting Citizen Portal...
          </span>
        </div>
      </div>
    </div>
  );
};
