import React, { useState } from 'react';
import { EMERGENCY_SERVICES } from '../constants/data';
import { EmergencyCard } from '../components/EmergencyCard';
import { EmergencyType, ScreenRoute } from '../types';
import { ShieldAlert, PhoneCall, AlertTriangle, LifeBuoy, HeartPulse } from 'lucide-react';

interface EmergencyScreenProps {
  onNavigate: (route: ScreenRoute) => void;
  language: 'en' | 'ta';
}

export const EmergencyScreen: React.FC<EmergencyScreenProps> = ({ onNavigate, language }) => {
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  const categories = [
    { id: 'all', label: language === 'ta' ? 'அனைத்து உதவிகள்' : 'All Helplines' },
    { id: 'police', label: language === 'ta' ? 'காவல்துறை' : 'Police' },
    { id: 'ambulance', label: language === 'ta' ? '108 ஆம்புலன்ஸ்' : 'Ambulance' },
    { id: 'fire', label: language === 'ta' ? 'தீயணைப்பு' : 'Fire Rescue' },
    { id: 'disaster', label: language === 'ta' ? 'பேரிடர் மேலாண்மை' : 'Disaster (DDMA)' },
    { id: 'women', label: language === 'ta' ? 'பெண்கள் & குழந்தைகள்' : 'Women & Child' },
    { id: 'coastGuard', label: language === 'ta' ? 'கடலோரப் பாதுகாப்பு' : 'Coast Guard' },
    { id: 'electricity', label: language === 'ta' ? 'மின்சார வாரியம்' : 'TNEB Power' },
  ];

  const filtered = selectedCategory === 'all'
    ? EMERGENCY_SERVICES
    : EMERGENCY_SERVICES.filter(e => e.type === selectedCategory);

  return (
    <div id="emergency-screen" className="space-y-6 pb-24 pt-2 animate-fade-in">
      {/* SOS Direct Dial Quick Bar */}
      <div className="rounded-3xl bg-linear-to-r from-red-600 to-rose-700 text-white p-6 shadow-md space-y-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <ShieldAlert className="w-6 h-6 text-white animate-pulse" />
            <span className="text-xs font-bold uppercase tracking-wider bg-white/20 px-2.5 py-1 rounded-full">
              Kanyakumari 24/7 Rapid SOS
            </span>
          </div>
          <span className="text-xs text-rose-100 font-semibold">Toll-Free</span>
        </div>

        <div>
          <h2 className="text-xl sm:text-2xl font-extrabold">Emergency Speed Dial</h2>
          <p className="text-xs text-rose-100 mt-1 max-w-sm leading-relaxed">
            One-touch direct dialing to district emergency first-responders.
          </p>
        </div>

        <div className="grid grid-cols-3 gap-2.5 pt-1">
          <a
            id="quick-call-112"
            href="tel:112"
            className="p-3 rounded-2xl bg-white/15 backdrop-blur-md hover:bg-white/25 border border-white/20 flex flex-col items-center justify-center text-center transition-transform active:scale-95"
          >
            <span className="text-2xl font-black">112</span>
            <span className="text-[11px] font-semibold text-rose-100">National SOS</span>
          </a>

          <a
            id="quick-call-108"
            href="tel:108"
            className="p-3 rounded-2xl bg-white/15 backdrop-blur-md hover:bg-white/25 border border-white/20 flex flex-col items-center justify-center text-center transition-transform active:scale-95"
          >
            <span className="text-2xl font-black">108</span>
            <span className="text-[11px] font-semibold text-rose-100">Ambulance</span>
          </a>

          <a
            id="quick-call-1077"
            href="tel:1077"
            className="p-3 rounded-2xl bg-white/15 backdrop-blur-md hover:bg-white/25 border border-white/20 flex flex-col items-center justify-center text-center transition-transform active:scale-95"
          >
            <span className="text-2xl font-black">1077</span>
            <span className="text-[11px] font-semibold text-rose-100">Disaster DDMA</span>
          </a>
        </div>
      </div>

      {/* Category Pills */}
      <div className="flex items-center gap-1.5 overflow-x-auto pb-1 no-scrollbar">
        {categories.map((cat) => (
          <button
            key={cat.id}
            id={`filter-emergency-${cat.id}`}
            type="button"
            onClick={() => setSelectedCategory(cat.id)}
            className={`py-1.5 px-3.5 rounded-full text-xs font-semibold whitespace-nowrap transition-colors ${
              selectedCategory === cat.id
                ? 'bg-[#00695C] text-white shadow-xs'
                : 'bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-800 text-slate-600 dark:text-slate-300 hover:bg-slate-50'
            }`}
          >
            {cat.label}
          </button>
        ))}
      </div>

      {/* Emergency Cards Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        {filtered.map((service) => (
          <EmergencyCard key={service.id} service={service} />
        ))}
      </div>
    </div>
  );
};
