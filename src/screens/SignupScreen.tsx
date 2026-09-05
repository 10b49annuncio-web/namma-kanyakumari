import React, { useState } from 'react';
import { ScreenRoute, UserModel } from '../types';
import { StorageService } from '../services/storage';
import { User, Mail, Phone, Lock, Eye, EyeOff, ArrowRight, ShieldCheck, CheckCircle2 } from 'lucide-react';

interface SignupScreenProps {
  onNavigate: (route: ScreenRoute) => void;
  onSignupSuccess: (user: UserModel) => void;
}

export const SignupScreen: React.FC<SignupScreenProps> = ({ onNavigate, onSignupSuccess }) => {
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [agreeTerms, setAgreeTerms] = useState(false);
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  // Real-time password strength calculation
  const getPasswordStrength = () => {
    if (!password) return { label: 'Empty', score: 0, color: 'bg-slate-200' };
    let score = 0;
    if (password.length >= 6) score++;
    if (password.length >= 8) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^A-Za-z0-9]/.test(password)) score++;

    if (score <= 2) return { label: 'Weak', score: 1, color: 'bg-red-500' };
    if (score <= 4) return { label: 'Medium', score: 2, color: 'bg-amber-500' };
    return { label: 'Strong', score: 3, color: 'bg-emerald-500' };
  };

  const handleSignup = (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!fullName.trim()) {
      setError('Please provide your full name');
      return;
    }
    if (!email.trim() || !email.includes('@')) {
      setError('Please enter a valid email address');
      return;
    }
    if (phone.replace(/\D/g, '').length < 10) {
      setError('Please enter a valid 10-digit mobile number');
      return;
    }
    if (password.length < 6) {
      setError('Password must be at least 6 characters');
      return;
    }
    if (password !== confirmPassword) {
      setError('Passwords do not match');
      return;
    }
    if (!agreeTerms) {
      setError('You must accept the terms of service and privacy policy');
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      const newUser: UserModel = {
        uid: `usr_${Date.now()}`,
        fullName: fullName.trim(),
        email: email.trim(),
        phoneNumber: phone.trim(),
        role: 'citizen',
        isVerified: true,
        isActive: true,
        district: 'Kanyakumari',
        taluk: 'Agastheeswaram',
        village: 'Nagercoil',
        pincode: '629001',
        createdAt: new Date().toISOString(),
      };
      StorageService.setCurrentUser(newUser);
      onSignupSuccess(newUser);
      onNavigate('home');
    }, 800);
  };

  const strength = getPasswordStrength();

  return (
    <div
      id="signup-screen"
      className="min-h-screen bg-[#F8FAFC] dark:bg-[#121212] flex flex-col justify-center py-10 px-4 sm:px-6"
    >
      <div className="max-w-md w-full mx-auto space-y-6">
        {/* Header */}
        <div className="text-center space-y-2">
          <div className="w-14 h-14 rounded-2xl bg-[#00695C] p-2 mx-auto flex items-center justify-center shadow-md">
            <img src="/assets/logo/app_icon.png" alt="Emblem" className="w-full h-full object-contain" />
          </div>
          <h1 className="text-2xl font-bold text-slate-900 dark:text-white">
            Create Citizen Account
          </h1>
          <p className="text-xs text-slate-600 dark:text-slate-300">
            Register for municipal grievance reporting in Kanyakumari
          </p>
        </div>

        {/* Card */}
        <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 sm:p-8 border border-slate-200 dark:border-slate-800 shadow-sm space-y-4">
          {error && (
            <div className="p-3 rounded-xl bg-red-50 dark:bg-red-950/40 border border-red-200 dark:border-red-900 text-red-600 dark:text-red-400 text-xs">
              {error}
            </div>
          )}

          <form onSubmit={handleSignup} className="space-y-3.5">
            {/* Full Name */}
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Full Name
              </label>
              <div className="relative">
                <User className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-signup-name"
                  type="text"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                  placeholder="e.g. Ramesh Kumar"
                  className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
                  required
                />
              </div>
            </div>

            {/* Email */}
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Email Address
              </label>
              <div className="relative">
                <Mail className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-signup-email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@domain.com"
                  className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
                  required
                />
              </div>
            </div>

            {/* Phone */}
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Mobile Number
              </label>
              <div className="relative flex items-center">
                <span className="absolute left-3.5 text-xs font-bold text-slate-500">
                  +91
                </span>
                <input
                  id="input-signup-phone"
                  type="tel"
                  maxLength={10}
                  value={phone}
                  onChange={(e) => setPhone(e.target.value.replace(/\D/g, ''))}
                  placeholder="9876543210"
                  className="w-full pl-12 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
                  required
                />
              </div>
            </div>

            {/* Password */}
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Password
              </label>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-signup-password"
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-10 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>

              {/* Password Strength Meter */}
              {password && (
                <div className="pt-1.5 space-y-1">
                  <div className="flex items-center justify-between text-[11px]">
                    <span className="text-slate-500">Security strength:</span>
                    <span className="font-semibold">{strength.label}</span>
                  </div>
                  <div className="h-1.5 w-full bg-slate-100 dark:bg-slate-700 rounded-full overflow-hidden flex gap-1">
                    <div className={`h-full flex-1 rounded-full ${strength.score >= 1 ? strength.color : 'bg-transparent'}`} />
                    <div className={`h-full flex-1 rounded-full ${strength.score >= 2 ? strength.color : 'bg-transparent'}`} />
                    <div className={`h-full flex-1 rounded-full ${strength.score >= 3 ? strength.color : 'bg-transparent'}`} />
                  </div>
                </div>
              )}
            </div>

            {/* Confirm Password */}
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Confirm Password
              </label>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-signup-confirm"
                  type="password"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C]"
                  required
                />
              </div>
            </div>

            {/* Terms Checkbox */}
            <div className="pt-1">
              <label className="flex items-start gap-2 cursor-pointer text-xs text-slate-600 dark:text-slate-400">
                <input
                  id="chk-terms"
                  type="checkbox"
                  checked={agreeTerms}
                  onChange={(e) => setAgreeTerms(e.target.checked)}
                  className="mt-0.5 rounded text-[#00695C] focus:ring-[#00695C]"
                />
                <span>
                  I agree to the <span className="text-[#00695C] font-semibold">Terms of Service</span> and acknowledge government grievance processing policies.
                </span>
              </label>
            </div>

            {/* Submit */}
            <button
              id="btn-signup-submit"
              type="submit"
              disabled={isLoading}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl bg-[#00695C] hover:bg-[#004D40] text-white font-semibold text-sm transition-all shadow-sm active:scale-[0.99] disabled:opacity-70 mt-2"
            >
              {isLoading ? (
                <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <>
                  <span>Create Account</span>
                  <ArrowRight className="w-4 h-4" />
                </>
              )}
            </button>
          </form>
        </div>

        {/* Back to Login */}
        <p className="text-center text-xs text-slate-600 dark:text-slate-400">
          Already registered?{' '}
          <button
            id="btn-switch-to-login"
            type="button"
            onClick={() => onNavigate('login')}
            className="font-bold text-[#00695C] dark:text-[#00897B] hover:underline ml-1"
          >
            Sign In
          </button>
        </p>
      </div>
    </div>
  );
};
