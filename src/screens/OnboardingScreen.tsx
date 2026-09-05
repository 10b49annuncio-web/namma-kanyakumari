import React, { useState } from 'react';
import { ScreenRoute } from '../types';
import { ONBOARDING_SLIDES } from '../constants/data';
import { StorageService } from '../services/storage';
import { ArrowRight, ArrowLeft, Check, Sparkles, Building2, Camera, Clock, ShieldAlert } from 'lucide-react';

interface OnboardingScreenProps {
  onNavigate: (route: ScreenRoute) => void;
}

export const OnboardingScreen: React.FC<OnboardingScreenProps> = ({ onNavigate }) => {
  const [currentIndex, setCurrentIndex] = useState(0);

  const handleFinish = () => {
    StorageService.setFirstTime(false);
    onNavigate('login');
  };

  const handleNext = () => {
    if (currentIndex < ONBOARDING_SLIDES.length - 1) {
      setCurrentIndex(prev => prev + 1);
    } else {
      handleFinish();
    }
  };

  const handlePrev = () => {
    if (currentIndex > 0) {
      setCurrentIndex(prev => prev - 1);
    }
  };

  const slide = ONBOARDING_SLIDES[currentIndex];

  const renderIcon = (fallback: string) => {
    switch (fallback) {
      case 'Building2':
        return <Building2 className="w-20 h-20 text-[#00695C]" />;
      case 'Camera':
        return <Camera className="w-20 h-20 text-[#00695C]" />;
      case 'Clock':
        return <Clock className="w-20 h-20 text-[#00695C]" />;
      case 'ShieldAlert':
        return <ShieldAlert className="w-20 h-20 text-[#00695C]" />;
      default:
        return <Sparkles className="w-20 h-20 text-[#00695C]" />;
    }
  };

  return (
    <div
      id="onboarding-screen"
      className="min-h-screen bg-[#F8FAFC] dark:bg-[#121212] flex flex-col justify-between p-6 max-w-md mx-auto"
    >
      {/* Top Header with Skip Button */}
      <div className="flex items-center justify-between pt-2">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-lg bg-[#00695C] p-1 flex items-center justify-center">
            <img src="/assets/logo/app_icon.png" alt="Icon" className="w-full h-full object-contain" />
          </div>
          <span className="text-xs font-bold text-[#00695C] dark:text-[#00897B] tracking-wider uppercase">
            Namma Kanyakumari
          </span>
        </div>

        {currentIndex < ONBOARDING_SLIDES.length - 1 && (
          <button
            id="btn-skip-onboarding"
            type="button"
            onClick={handleFinish}
            className="text-xs font-semibold text-slate-500 dark:text-slate-400 hover:text-[#00695C] transition-colors px-2 py-1"
          >
            Skip
          </button>
        )}
      </div>

      {/* Main Slide Card */}
      <div className="my-auto py-8 flex flex-col items-center text-center space-y-6">
        {/* Graphic Area */}
        <div className="w-64 h-64 sm:w-72 sm:h-72 rounded-3xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 shadow-sm p-6 flex items-center justify-center overflow-hidden">
          <img
            src={slide.image}
            alt={slide.title}
            className="w-full h-full object-contain"
            onError={(e) => {
              // Hide broken image and fallback to vector icon
              (e.target as HTMLElement).style.display = 'none';
              const parent = (e.target as HTMLElement).parentElement;
              if (parent && !parent.querySelector('.fallback-icon')) {
                const iconDiv = document.createElement('div');
                iconDiv.className = 'fallback-icon flex items-center justify-center';
                parent.appendChild(iconDiv);
              }
            }}
          />
        </div>

        {/* Title & Description */}
        <div className="space-y-3 px-4">
          <h2 className="text-2xl sm:text-3xl font-bold text-slate-900 dark:text-white leading-tight whitespace-pre-line">
            {slide.title}
          </h2>
          <p className="text-sm text-slate-600 dark:text-slate-300 leading-relaxed max-w-xs mx-auto">
            {slide.subtitle}
          </p>
        </div>

        {/* Step Indicators */}
        <div className="flex items-center gap-2 pt-2">
          {ONBOARDING_SLIDES.map((_, idx) => (
            <button
              key={idx}
              id={`indicator-dot-${idx}`}
              type="button"
              onClick={() => setCurrentIndex(idx)}
              className={`h-2 rounded-full transition-all duration-300 ${
                idx === currentIndex
                  ? 'w-7 bg-[#00695C] dark:bg-[#00897B]'
                  : 'w-2 bg-slate-300 dark:bg-slate-700'
              }`}
              aria-label={`Go to slide ${idx + 1}`}
            />
          ))}
        </div>
      </div>

      {/* Bottom Navigation Controls */}
      <div className="pb-4 pt-2 flex items-center gap-3">
        {currentIndex > 0 ? (
          <button
            id="btn-onboarding-prev"
            type="button"
            onClick={handlePrev}
            className="p-3.5 rounded-2xl border border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
            aria-label="Previous slide"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
        ) : (
          <div className="w-0" />
        )}

        <button
          id="btn-onboarding-next"
          type="button"
          onClick={handleNext}
          className="flex-1 flex items-center justify-center gap-2 py-3.5 px-6 rounded-2xl bg-[#00695C] hover:bg-[#004D40] text-white font-semibold text-sm shadow-sm transition-all active:scale-[0.99]"
        >
          {currentIndex === ONBOARDING_SLIDES.length - 1 ? (
            <>
              <span>Get Started</span>
              <Check className="w-5 h-5" />
            </>
          ) : (
            <>
              <span>Continue</span>
              <ArrowRight className="w-5 h-5" />
            </>
          )}
        </button>
      </div>
    </div>
  );
};
