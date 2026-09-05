import React from 'react';
import { DEPARTMENTS, KANYAKUMARI_TALUKS } from '../constants/data';
import { Building, Phone, Mail, MapPin, Users, CheckCircle2 } from 'lucide-react';

interface GovServicesScreenProps {
  language: 'en' | 'ta';
}

export const GovServicesScreen: React.FC<GovServicesScreenProps> = ({ language }) => {
  return (
    <div id="gov-services-screen" className="space-y-6 pb-24 pt-2 animate-fade-in">
      {/* Overview Banner */}
      <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 border border-slate-200 dark:border-slate-800 shadow-xs space-y-2">
        <div className="w-10 h-10 rounded-2xl bg-teal-50 dark:bg-teal-950/50 flex items-center justify-center text-[#00695C] dark:text-teal-300">
          <Building className="w-5 h-5" />
        </div>
        <h2 className="text-lg font-bold text-slate-900 dark:text-white">
          {language === 'ta' ? 'கன்னியாகுமரி அரசு அலுவலகங்கள்' : 'District Administration Directory'}
        </h2>
        <p className="text-xs text-slate-600 dark:text-slate-300 leading-relaxed">
          Official contact points and departmental divisions across Kanyakumari district for public service delivery and grievance escalation.
        </p>
      </div>

      {/* Taluk Offices Section */}
      <div className="bg-slate-50 dark:bg-slate-800/40 rounded-3xl p-5 border border-slate-200 dark:border-slate-800 space-y-3">
        <h3 className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
          Revenue Taluk Jurisdictions
        </h3>
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
          {KANYAKUMARI_TALUKS.map((t, idx) => (
            <div
              key={idx}
              className="p-2.5 rounded-xl bg-white dark:bg-[#1E1E1E] border border-slate-200 dark:border-slate-700 text-xs font-semibold text-slate-800 dark:text-slate-200"
            >
              {t}
            </div>
          ))}
        </div>
      </div>

      {/* Main Civic Departments */}
      <div className="space-y-4">
        <h3 className="text-sm font-bold text-slate-900 dark:text-white uppercase tracking-wider">
          Key Civic Authorities
        </h3>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {DEPARTMENTS.map((dept) => (
            <div
              key={dept.departmentId}
              id={`dept-card-${dept.departmentId}`}
              className="bg-white dark:bg-[#1E1E1E] rounded-2xl p-5 border border-slate-200 dark:border-slate-800 shadow-xs space-y-3 flex flex-col justify-between"
            >
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <h4 className="font-bold text-slate-900 dark:text-white text-base">
                    {dept.name}
                  </h4>
                  <span className="text-[11px] font-semibold text-teal-700 dark:text-teal-400 bg-teal-50 dark:bg-teal-950/50 px-2 py-0.5 rounded-full flex items-center gap-1">
                    <Users className="w-3 h-3" />
                    {dept.totalOfficers} Officers
                  </span>
                </div>

                <p className="text-xs text-slate-600 dark:text-slate-300 leading-relaxed">
                  {dept.description}
                </p>

                <div className="space-y-1.5 pt-2 text-xs text-slate-600 dark:text-slate-400">
                  <div className="flex items-center gap-2">
                    <MapPin className="w-3.5 h-3.5 text-slate-400 shrink-0" />
                    <span className="truncate">{dept.officeAddress}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Phone className="w-3.5 h-3.5 text-[#00695C] shrink-0" />
                    <a href={`tel:${dept.phoneNumber}`} className="hover:underline text-slate-800 dark:text-slate-200 font-medium">
                      {dept.phoneNumber}
                    </a>
                  </div>
                  <div className="flex items-center gap-2">
                    <Mail className="w-3.5 h-3.5 text-[#00695C] shrink-0" />
                    <span className="truncate">{dept.email}</span>
                  </div>
                </div>
              </div>

              {/* Handled Categories */}
              <div className="pt-3 border-t border-slate-100 dark:border-slate-800">
                <p className="text-[11px] font-semibold text-slate-500 mb-1.5">
                  Handles Grievances:
                </p>
                <div className="flex flex-wrap gap-1">
                  {dept.complaintCategories.map((cat, idx) => (
                    <span
                      key={idx}
                      className="text-[10px] font-medium bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-300 px-2 py-0.5 rounded-md"
                    >
                      {cat}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
