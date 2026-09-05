import React, { useState } from 'react';
import { ComplaintModel, ComplaintPriority, ScreenRoute, UserModel } from '../types';
import { COMPLAINT_CATEGORIES, KANYAKUMARI_TALUKS } from '../constants/data';
import { StorageService } from '../services/storage';
import {
  Camera,
  MapPin,
  Sparkles,
  Upload,
  CheckCircle2,
  AlertCircle,
  X,
  Navigation,
  Loader2,
  Tag,
  ShieldCheck
} from 'lucide-react';

interface ReportComplaintScreenProps {
  user: UserModel | null;
  onNavigate: (route: ScreenRoute) => void;
  onComplaintAdded: (complaint: ComplaintModel) => void;
  language: 'en' | 'ta';
}

const SAMPLE_IMAGES = [
  {
    name: 'Damaged Road & Pothole',
    category: 'Roads & Potholes',
    aiPrediction: 'Asphalt Pothole & Road Deterioration',
    url: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&w=800&q=80',
  },
  {
    name: 'Broken Streetlight',
    category: 'Streetlights & Electricity',
    aiPrediction: 'Non-functional Municipal Streetlight',
    url: 'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?auto=format&fit=crop&w=800&q=80',
  },
  {
    name: 'Water Pipeline Leakage',
    category: 'Water Supply & Drainage',
    aiPrediction: 'High Pressure Water Pipe Rupture',
    url: 'https://images.unsplash.com/photo-1584467735871-8e85353a8413?auto=format&fit=crop&w=800&q=80',
  },
  {
    name: 'Overflowing Garbage Bin',
    category: 'Sanitation & Garbage',
    aiPrediction: 'Municipal Waste Bin Overflow',
    url: 'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?auto=format&fit=crop&w=800&q=80',
  }
];

export const ReportComplaintScreen: React.FC<ReportComplaintScreenProps> = ({
  user,
  onNavigate,
  onComplaintAdded,
  language,
}) => {
  const [category, setCategory] = useState(COMPLAINT_CATEGORIES[1]);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [priority, setPriority] = useState<ComplaintPriority>('medium');
  const [taluk, setTaluk] = useState(KANYAKUMARI_TALUKS[0]);
  const [address, setAddress] = useState('Vadasery, Nagercoil, Kanyakumari District - 629001');
  const [selectedImage, setSelectedImage] = useState<string>(SAMPLE_IMAGES[0].url);
  const [aiScanning, setAiScanning] = useState(false);
  const [aiPrediction, setAiPrediction] = useState<string>(SAMPLE_IMAGES[0].aiPrediction);
  const [aiConfidence, setAiConfidence] = useState<number>(0.94);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [successModal, setSuccessModal] = useState<ComplaintModel | null>(null);

  // AI Scanner Simulation when an image is selected
  const handleSelectSampleImage = (item: typeof SAMPLE_IMAGES[0]) => {
    setSelectedImage(item.url);
    setAiScanning(true);
    setTimeout(() => {
      setAiScanning(false);
      setCategory(item.category);
      setAiPrediction(item.aiPrediction);
      setAiConfidence(0.92 + Math.random() * 0.06);
      if (!title) {
        setTitle(item.name + ' in ' + taluk.split(' ')[0]);
      }
    }, 900);
  };

  const handleCustomFileUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        const result = reader.result as string;
        setSelectedImage(result);
        setAiScanning(true);
        setTimeout(() => {
          setAiScanning(false);
          setAiPrediction('Visual Civic Hazard Identified');
          setAiConfidence(0.89);
        }, 900);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleUseCurrentLocation = () => {
    setAddress('Beach Road, near Gandhi Mandapam, Kanyakumari - 629702 (GPS: 8.0805° N, 77.5510° E)');
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !description.trim()) return;

    setIsSubmitting(true);

    setTimeout(() => {
      setIsSubmitting(false);

      const generatedId = `KK-${new Date().getFullYear()}-${Math.floor(1000 + Math.random() * 9000)}`;
      const newComplaint: ComplaintModel = {
        complaintId: generatedId,
        userId: user?.uid || 'usr_citizen_demo',
        userName: user?.fullName || 'Karthik Raja',
        phoneNumber: user?.phoneNumber || '9842145678',
        category,
        title: title.trim(),
        description: description.trim(),
        imageUrls: [selectedImage],
        latitude: 8.1873,
        longitude: 77.4278,
        address,
        status: 'submitted',
        priority,
        departmentName: category.includes('Road')
          ? 'State Highways & Municipal Roads'
          : category.includes('Light') || category.includes('Electricity')
          ? 'TANGEDCO Electricity Division'
          : category.includes('Water')
          ? 'TWAD Water Supply Board'
          : 'Nagercoil Municipal Sanitation',
        aiDetected: true,
        aiPrediction,
        aiConfidence,
        createdAt: new Date().toISOString(),
        isPublic: true,
      };

      StorageService.saveComplaint(newComplaint);
      onComplaintAdded(newComplaint);
      setSuccessModal(newComplaint);
    }, 800);
  };

  return (
    <div id="report-complaint-screen" className="max-w-2xl mx-auto space-y-6 pb-24 pt-2">
      {/* Header Info */}
      <div className="bg-teal-50 dark:bg-teal-950/40 border border-teal-100 dark:border-teal-900/60 rounded-3xl p-5 flex items-start gap-3.5">
        <div className="w-10 h-10 rounded-2xl bg-[#00695C] text-white flex items-center justify-center shrink-0 shadow-xs">
          <Sparkles className="w-5 h-5 text-teal-200" />
        </div>
        <div>
          <h2 className="text-sm sm:text-base font-bold text-slate-900 dark:text-white">
            Smart AI Civic Redressal
          </h2>
          <p className="text-xs text-slate-600 dark:text-slate-300 mt-0.5 leading-relaxed">
            Upload a photo of the road damage, water leak, or street light issue. Our AI automatically classifies the problem and dispatches it to the concerned Kanyakumari district department.
          </p>
        </div>
      </div>

      {/* Main Reporting Form */}
      <form onSubmit={handleSubmit} className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 border border-slate-200 dark:border-slate-800 shadow-xs space-y-5">
        {/* Photo Upload & AI Scan Section */}
        <div className="space-y-2.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300 flex items-center justify-between">
            <span>Issue Photograph</span>
            <span className="text-[11px] text-[#00695C] dark:text-[#00897B] font-semibold">
              Required for verification
            </span>
          </label>

          {/* Main Image Preview */}
          <div className="relative rounded-2xl overflow-hidden h-52 bg-slate-100 dark:bg-slate-800 border-2 border-dashed border-slate-300 dark:border-slate-700 flex flex-col items-center justify-center group">
            {selectedImage ? (
              <>
                <img src={selectedImage} alt="Issue Preview" className="w-full h-full object-cover" />
                {aiScanning && (
                  <div className="absolute inset-0 bg-slate-900/70 backdrop-blur-xs flex flex-col items-center justify-center text-white space-y-2">
                    <Loader2 className="w-8 h-8 animate-spin text-teal-300" />
                    <p className="text-xs font-semibold">AI Analyzing Defect & Severity...</p>
                  </div>
                )}
                {!aiScanning && aiPrediction && (
                  <div className="absolute bottom-3 left-3 right-3 bg-[#004D40]/90 backdrop-blur-md text-white text-xs p-2.5 rounded-xl flex items-center justify-between shadow-sm">
                    <div className="flex items-center gap-2">
                      <ShieldCheck className="w-4 h-4 text-teal-300 shrink-0" />
                      <span className="font-semibold truncate">{aiPrediction}</span>
                    </div>
                    <span className="text-[11px] font-mono text-teal-200 shrink-0">
                      {Math.round(aiConfidence * 100)}% confidence
                    </span>
                  </div>
                )}
              </>
            ) : (
              <div className="text-center p-4 space-y-2">
                <Camera className="w-8 h-8 text-slate-400 mx-auto" />
                <p className="text-xs text-slate-500">Tap to upload or select a sample image below</p>
              </div>
            )}
          </div>

          {/* Quick Sample Selector */}
          <div className="space-y-1.5 pt-1">
            <span className="text-[11px] font-semibold text-slate-500 dark:text-slate-400">
              Or pick sample issue photo:
            </span>
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
              {SAMPLE_IMAGES.map((item, idx) => (
                <button
                  key={idx}
                  type="button"
                  onClick={() => handleSelectSampleImage(item)}
                  className={`p-2 rounded-xl border text-left flex items-center gap-2 transition-all ${
                    selectedImage === item.url
                      ? 'border-[#00695C] bg-teal-50/70 dark:bg-teal-950/40 ring-1 ring-[#00695C]'
                      : 'border-slate-200 dark:border-slate-800 hover:border-slate-300 dark:hover:border-slate-700'
                  }`}
                >
                  <img src={item.url} alt={item.name} className="w-8 h-8 rounded-lg object-cover" />
                  <span className="text-[11px] font-medium text-slate-800 dark:text-slate-200 leading-tight line-clamp-1">
                    {item.name.split(' ')[0]}
                  </span>
                </button>
              ))}
            </div>
          </div>

          {/* Manual File Input */}
          <label className="cursor-pointer inline-flex items-center gap-2 text-xs font-semibold text-[#00695C] dark:text-[#00897B] hover:underline pt-1">
            <Upload className="w-3.5 h-3.5" />
            <span>Upload custom photo from gallery / camera</span>
            <input
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleCustomFileUpload}
            />
          </label>
        </div>

        {/* Category Dropdown */}
        <div className="space-y-1.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
            Civic Category
          </label>
          <select
            id="select-complaint-category"
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            className="w-full px-3.5 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white focus:outline-none focus:border-[#00695C]"
          >
            {COMPLAINT_CATEGORIES.map((cat) => (
              <option key={cat} value={cat}>
                {cat}
              </option>
            ))}
          </select>
        </div>

        {/* Issue Title */}
        <div className="space-y-1.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
            Brief Title
          </label>
          <input
            id="input-complaint-title"
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="e.g. Broken road surface near Vadasery stand"
            className="w-full px-3.5 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
            required
          />
        </div>

        {/* Detailed Description */}
        <div className="space-y-1.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
            Problem Description
          </label>
          <textarea
            id="input-complaint-description"
            rows={3}
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Please detail exact landmark, duration of the issue, and immediate safety risks..."
            className="w-full px-3.5 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
            required
          />
        </div>

        {/* Priority Selector */}
        <div className="space-y-1.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
            Urgency Level
          </label>
          <div className="grid grid-cols-4 gap-2">
            {(['low', 'medium', 'high', 'emergency'] as ComplaintPriority[]).map((lvl) => (
              <button
                key={lvl}
                id={`btn-priority-${lvl}`}
                type="button"
                onClick={() => setPriority(lvl)}
                className={`py-2 px-2 rounded-xl text-xs font-semibold capitalize border transition-all ${
                  priority === lvl
                    ? lvl === 'emergency'
                      ? 'bg-red-600 text-white border-red-600 shadow-xs'
                      : 'bg-[#00695C] text-white border-[#00695C] shadow-xs'
                    : 'bg-slate-50 dark:bg-slate-800 text-slate-700 dark:text-slate-300 border-slate-200 dark:border-slate-700'
                }`}
              >
                {lvl}
              </button>
            ))}
          </div>
        </div>

        {/* Taluk / Municipality Selector */}
        <div className="space-y-1.5">
          <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
            Taluk / Revenue Zone
          </label>
          <select
            id="select-complaint-taluk"
            value={taluk}
            onChange={(e) => setTaluk(e.target.value)}
            className="w-full px-3.5 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white focus:outline-none focus:border-[#00695C]"
          >
            {KANYAKUMARI_TALUKS.map((t) => (
              <option key={t} value={t}>
                {t}
              </option>
            ))}
          </select>
        </div>

        {/* Location & GPS */}
        <div className="space-y-1.5">
          <div className="flex items-center justify-between">
            <label className="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300">
              Precise Address / Landmark
            </label>
            <button
              id="btn-use-gps"
              type="button"
              onClick={handleUseCurrentLocation}
              className="inline-flex items-center gap-1 text-xs font-semibold text-[#00695C] dark:text-[#00897B] hover:underline"
            >
              <Navigation className="w-3.5 h-3.5" />
              <span>Use Current GPS</span>
            </button>
          </div>
          <div className="relative">
            <MapPin className="w-4 h-4 text-red-500 absolute left-3.5 top-3" />
            <input
              id="input-complaint-address"
              type="text"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              placeholder="Door No, Street, Landmark, Town, Pincode"
              className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white focus:outline-none focus:border-[#00695C]"
              required
            />
          </div>
        </div>

        {/* Submit Action */}
        <button
          id="btn-submit-complaint"
          type="submit"
          disabled={isSubmitting}
          className="w-full py-3.5 px-6 rounded-2xl bg-[#00695C] hover:bg-[#004D40] text-white font-bold text-sm shadow-md transition-all active:scale-[0.99] flex items-center justify-center gap-2 disabled:opacity-75"
        >
          {isSubmitting ? (
            <div className="flex items-center gap-2">
              <Loader2 className="w-4 h-4 animate-spin" />
              <span>Registering with District Portal...</span>
            </div>
          ) : (
            <>
              <CheckCircle2 className="w-5 h-5" />
              <span>Submit Civic Complaint</span>
            </>
          )}
        </button>
      </form>

      {/* Success Confirmation Modal */}
      {successModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 animate-fade-in">
          <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 sm:p-8 max-w-md w-full border border-slate-200 dark:border-slate-800 shadow-2xl text-center space-y-5">
            <div className="w-16 h-16 rounded-full bg-emerald-100 dark:bg-emerald-950/60 text-emerald-600 dark:text-emerald-400 mx-auto flex items-center justify-center">
              <CheckCircle2 className="w-10 h-10" />
            </div>

            <div className="space-y-1.5">
              <h3 className="text-xl font-bold text-slate-900 dark:text-white">
                Complaint Registered!
              </h3>
              <p className="text-xs font-mono font-bold text-[#00695C] dark:text-[#00897B] bg-teal-50 dark:bg-teal-950/50 py-1 px-3 rounded-full inline-block">
                Ticket ID: {successModal.complaintId}
              </p>
              <p className="text-xs text-slate-600 dark:text-slate-300 pt-2 leading-relaxed">
                Your report has been received and routed to <span className="font-semibold text-slate-800 dark:text-slate-200">{successModal.departmentName}</span>. You will receive SMS & push notifications as field verification begins.
              </p>
            </div>

            <div className="pt-2 flex flex-col gap-2">
              <button
                type="button"
                onClick={() => {
                  setSuccessModal(null);
                  onNavigate('complaint_history');
                }}
                className="w-full py-3 px-4 rounded-xl bg-[#00695C] text-white font-semibold text-xs sm:text-sm hover:bg-[#004D40] transition-colors"
              >
                Track in Complaint History
              </button>

              <button
                type="button"
                onClick={() => {
                  setSuccessModal(null);
                  onNavigate('home');
                }}
                className="w-full py-2.5 px-4 rounded-xl text-slate-600 dark:text-slate-400 text-xs font-medium hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
              >
                Back to Home
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
