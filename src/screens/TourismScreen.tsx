import React from 'react';
import { TOURISM_PLACES } from '../constants/data';
import { TourismPlace } from '../types';
import { MapPin, Clock, Ticket, Sparkles, Navigation } from 'lucide-react';

interface TourismScreenProps {
  language: 'en' | 'ta';
}

export const TourismScreen: React.FC<TourismScreenProps> = ({ language }) => {
  return (
    <div id="tourism-screen" className="space-y-6 pb-24 pt-2 animate-fade-in">
      {/* Header Banner */}
      <div className="rounded-3xl bg-linear-to-r from-[#00695C] to-[#00897B] text-white p-6 shadow-sm space-y-2">
        <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/15 backdrop-blur-md text-teal-100 text-xs font-semibold">
          <Sparkles className="w-3.5 h-3.5 text-teal-300" />
          <span>Pride of Tamil Nadu</span>
        </div>
        <h2 className="text-xl sm:text-2xl font-bold">
          {language === 'ta' ? 'கன்னியாகுமரி சுற்றுலா & பாரம்பரியம்' : 'Kanyakumari Heritage & Tourism'}
        </h2>
        <p className="text-xs sm:text-sm text-teal-100/90 leading-relaxed max-w-lg">
          The southernmost tip of the Indian subcontinent where the Arabian Sea, the Indian Ocean, and the Bay of Bengal converge in Triveni Sangam.
        </p>
      </div>

      {/* Tourism Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
        {TOURISM_PLACES.map((place) => (
          <div
            key={place.id}
            id={`tourism-card-${place.id}`}
            className="bg-white dark:bg-[#1E1E1E] rounded-3xl overflow-hidden border border-slate-200 dark:border-slate-800 shadow-xs flex flex-col justify-between group hover:shadow-md transition-all"
          >
            <div>
              {/* Photo */}
              <div className="relative h-48 w-full overflow-hidden bg-slate-100 dark:bg-slate-800">
                <img
                  src={place.imageUrl}
                  alt={place.name}
                  className="w-full h-full object-cover group-hover:scale-102 transition-transform duration-500"
                  onError={(e) => {
                    (e.target as HTMLImageElement).src = 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80';
                  }}
                />
                <div className="absolute top-3 left-3 bg-[#004D40]/85 backdrop-blur-md text-white text-[11px] font-semibold px-3 py-1 rounded-full flex items-center gap-1">
                  <MapPin className="w-3 h-3 text-teal-300" />
                  <span>{place.location}</span>
                </div>
              </div>

              {/* Information */}
              <div className="p-5 space-y-3">
                <div>
                  <h3 className="text-lg font-bold text-slate-900 dark:text-white leading-tight">
                    {place.name}
                  </h3>
                  <p className="text-xs text-[#00695C] dark:text-[#00897B] font-semibold mt-0.5">
                    {place.tamilName}
                  </p>
                  <p className="text-xs text-slate-600 dark:text-slate-300 mt-2 leading-relaxed">
                    {place.description}
                  </p>
                </div>

                {/* Key timings & ticket */}
                <div className="bg-slate-50 dark:bg-slate-800/50 rounded-2xl p-3 space-y-1.5 text-xs text-slate-700 dark:text-slate-300 border border-slate-100 dark:border-slate-800">
                  <div className="flex items-center gap-2">
                    <Clock className="w-3.5 h-3.5 text-[#00695C] shrink-0" />
                    <span>Timings: {place.timing}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Ticket className="w-3.5 h-3.5 text-amber-600 shrink-0" />
                    <span>Entry: {place.entryFee}</span>
                  </div>
                </div>

                {/* Highlights */}
                <div className="space-y-1 pt-1">
                  <p className="text-[11px] font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                    Visitor Highlights:
                  </p>
                  <div className="flex flex-wrap gap-1.5">
                    {place.highlights.map((hl, idx) => (
                      <span
                        key={idx}
                        className="text-[11px] font-medium bg-teal-50 dark:bg-teal-950/40 text-[#00695C] dark:text-teal-300 px-2 py-0.5 rounded-lg"
                      >
                        • {hl}
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
