import React from 'react';
import { EmergencyModel } from '../types';
import { Phone, Shield, Ambulance, Flame, AlertTriangle, Anchor, HeartHandshake, Zap, Droplets, MapPin, Clock } from 'lucide-react';

interface EmergencyCardProps {
  service: EmergencyModel;
}

export const EmergencyCard: React.FC<EmergencyCardProps> = ({ service }) => {
  const getIcon = () => {
    switch (service.type) {
      case 'police':
        return <Shield className="w-6 h-6 text-[#1565C0]" />;
      case 'ambulance':
        return <Ambulance className="w-6 h-6 text-[#D32F2F]" />;
      case 'fire':
        return <Flame className="w-6 h-6 text-[#FF5722]" />;
      case 'disaster':
        return <AlertTriangle className="w-6 h-6 text-[#6A1B9A]" />;
      case 'coastGuard':
        return <Anchor className="w-6 h-6 text-[#00695C]" />;
      case 'women':
      case 'child':
        return <HeartHandshake className="w-6 h-6 text-[#C2185B]" />;
      case 'electricity':
        return <Zap className="w-6 h-6 text-[#F57C00]" />;
      case 'water':
        return <Droplets className="w-6 h-6 text-[#0288D1]" />;
      default:
        return <Phone className="w-6 h-6 text-[#00695C]" />;
    }
  };

  const getBorderColor = () => {
    switch (service.type) {
      case 'police':
        return 'hover:border-blue-300';
      case 'ambulance':
        return 'hover:border-red-300';
      case 'fire':
        return 'hover:border-orange-300';
      case 'disaster':
        return 'hover:border-purple-300';
      default:
        return 'hover:border-teal-300';
    }
  };

  return (
    <div
      id={`emergency-card-${service.id}`}
      className={`bg-white dark:bg-[#1E1E1E] rounded-2xl p-4 sm:p-5 border border-slate-200 dark:border-slate-800 shadow-xs transition-all ${getBorderColor()}`}
    >
      <div className="flex items-start gap-4">
        <div className="w-12 h-12 rounded-2xl bg-slate-50 dark:bg-slate-800 flex items-center justify-center shrink-0 border border-slate-100 dark:border-slate-700 shadow-xs">
          {getIcon()}
        </div>

        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between gap-2">
            <h3 className="font-bold text-slate-900 dark:text-white text-base truncate">
              {service.name}
            </h3>
            {service.is24Hours && (
              <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-emerald-700 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-950/50 px-2 py-0.5 rounded-full shrink-0">
                <Clock className="w-3 h-3" />
                24/7
              </span>
            )}
          </div>

          <p className="text-slate-600 dark:text-slate-300 text-xs sm:text-sm mt-1 line-clamp-2 leading-relaxed">
            {service.description}
          </p>

          <div className="mt-2.5 flex items-center gap-1.5 text-xs text-slate-500 dark:text-slate-400">
            <MapPin className="w-3.5 h-3.5 text-slate-400 shrink-0" />
            <span className="truncate">{service.address}</span>
          </div>

          <div className="mt-4 flex flex-wrap items-center gap-2">
            <a
              id={`call-primary-${service.id}`}
              href={`tel:${service.phoneNumber}`}
              className="inline-flex items-center gap-2 py-2 px-4 rounded-xl bg-red-600 hover:bg-red-700 text-white font-semibold text-sm shadow-xs transition-colors"
            >
              <Phone className="w-4 h-4" />
              <span>Call {service.phoneNumber}</span>
            </a>

            {service.alternatePhone && (
              <a
                id={`call-alt-${service.id}`}
                href={`tel:${service.alternatePhone}`}
                className="inline-flex items-center gap-1.5 py-2 px-3 rounded-xl border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-medium transition-colors"
              >
                <span>Landline: {service.alternatePhone}</span>
              </a>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};
