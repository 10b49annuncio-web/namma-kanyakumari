import React, { useState } from 'react';
import { ScreenRoute, UserModel } from '../types';
import { StorageService } from '../services/storage';
import { DEMO_USER } from '../constants/data';
import { Mail, Lock, Eye, EyeOff, Fingerprint, ArrowRight, CheckCircle, AlertCircle, Sparkles } from 'lucide-react';

interface LoginScreenProps {
  onNavigate: (route: ScreenRoute) => void;
  onLoginSuccess: (user: UserModel) => void;
}

export const LoginScreen: React.FC<LoginScreenProps> = ({ onNavigate, onLoginSuccess }) => {
  const [email, setEmail] = useState('karthik.raja@gmail.com');
  const [password, setPassword] = useState('SecurePass@123');
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(true);
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');
  const [showForgotModal, setShowForgotModal] = useState(false);
  const [forgotEmail, setForgotEmail] = useState('');
  const [forgotSubmitted, setForgotSubmitted] = useState(false);

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage('');

    if (!email.trim() || !password.trim()) {
      setErrorMessage('Please enter your email and password');
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      // Log in with user details
      const user: UserModel = {
        ...DEMO_USER,
        email: email.trim(),
        fullName: email.includes('karthik') ? 'Karthik Raja' : email.split('@')[0],
      };
      StorageService.setCurrentUser(user);
      onLoginSuccess(user);
      onNavigate('home');
    }, 700);
  };

  const handleBiometricLogin = () => {
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      StorageService.setCurrentUser(DEMO_USER);
      onLoginSuccess(DEMO_USER);
      onNavigate('home');
    }, 600);
  };

  const handleSocialLogin = (provider: 'Google' | 'Apple') => {
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      const socialUser: UserModel = {
        ...DEMO_USER,
        fullName: `${provider} Citizen User`,
        email: `citizen.${provider.toLowerCase()}@kanyakumari.gov.in`,
      };
      StorageService.setCurrentUser(socialUser);
      onLoginSuccess(socialUser);
      onNavigate('home');
    }, 700);
  };

  return (
    <div
      id="login-screen"
      className="min-h-screen bg-[#F8FAFC] dark:bg-[#121212] flex flex-col justify-center py-10 px-4 sm:px-6"
    >
      <div className="max-w-md w-full mx-auto space-y-6">
        {/* Header Branding */}
        <div className="text-center space-y-2">
          <div className="w-16 h-16 rounded-2xl bg-[#00695C] p-2.5 mx-auto flex items-center justify-center shadow-md">
            <img src="/assets/logo/app_icon.png" alt="Emblem" className="w-full h-full object-contain" />
          </div>
          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900 dark:text-white">
            Namma Kanyakumari
          </h1>
          <p className="text-xs sm:text-sm text-slate-600 dark:text-slate-300">
            Sign in to access civic services & track district complaints
          </p>
        </div>

        {/* Form Card */}
        <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 sm:p-8 border border-slate-200 dark:border-slate-800 shadow-sm space-y-5">
          {errorMessage && (
            <div className="p-3.5 rounded-xl bg-red-50 dark:bg-red-950/40 border border-red-200 dark:border-red-900/60 text-red-600 dark:text-red-400 text-xs flex items-center gap-2">
              <AlertCircle className="w-4 h-4 shrink-0" />
              <span>{errorMessage}</span>
            </div>
          )}

          <form onSubmit={handleLogin} className="space-y-4">
            {/* Email Field */}
            <div className="space-y-1.5">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Email Address
              </label>
              <div className="relative">
                <Mail className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-login-email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@example.com"
                  className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C] transition-colors"
                  required
                />
              </div>
            </div>

            {/* Password Field */}
            <div className="space-y-1.5">
              <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                Password
              </label>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  id="input-login-password"
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-10 py-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-sm text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00695C] transition-colors"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 dark:hover:text-slate-200"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>

            {/* Remember Me & Forgot Password */}
            <div className="flex items-center justify-between text-xs pt-1">
              <label className="flex items-center gap-2 cursor-pointer text-slate-600 dark:text-slate-300">
                <input
                  id="chk-remember-me"
                  type="checkbox"
                  checked={rememberMe}
                  onChange={(e) => setRememberMe(e.target.checked)}
                  className="rounded text-[#00695C] focus:ring-[#00695C]"
                />
                <span>Remember me</span>
              </label>

              <button
                id="btn-forgot-password"
                type="button"
                onClick={() => setShowForgotModal(true)}
                className="font-medium text-[#00695C] dark:text-[#00897B] hover:underline"
              >
                Forgot Password?
              </button>
            </div>

            {/* Biometric Toggle Matching Flutter Switch */}
            <div className="p-3 rounded-2xl bg-teal-50/70 dark:bg-teal-950/30 border border-teal-100 dark:border-teal-900/50 flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <Fingerprint className="w-5 h-5 text-[#00695C] dark:text-teal-300" />
                <span className="text-xs font-semibold text-slate-800 dark:text-slate-200">
                  Biometric Login
                </span>
              </div>
              <button
                id="btn-biometric-toggle"
                type="button"
                onClick={handleBiometricLogin}
                className="text-xs font-semibold text-[#00695C] dark:text-teal-300 hover:underline px-2 py-1"
              >
                Use Touch ID
              </button>
            </div>

            {/* Submit Button */}
            <button
              id="btn-login-submit"
              type="submit"
              disabled={isLoading}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl bg-[#00695C] hover:bg-[#004D40] text-white font-semibold text-sm transition-all shadow-sm active:scale-[0.99] disabled:opacity-70"
            >
              {isLoading ? (
                <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <>
                  <span>Sign In</span>
                  <ArrowRight className="w-4 h-4" />
                </>
              )}
            </button>
          </form>

          {/* Social Logins */}
          <div className="space-y-3 pt-2">
            <div className="relative flex items-center justify-center">
              <div className="border-t border-slate-200 dark:border-slate-800 w-full" />
              <span className="bg-white dark:bg-[#1E1E1E] px-3 text-[11px] font-medium text-slate-400 uppercase tracking-wider">
                Or continue with
              </span>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <button
                id="btn-login-google"
                type="button"
                onClick={() => handleSocialLogin('Google')}
                className="flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold text-slate-700 dark:text-slate-200 transition-colors"
              >
                <img src="/assets/google.png" alt="Google" className="w-4 h-4" onError={(e) => { (e.target as HTMLElement).style.display = 'none'; }} />
                <span>Google</span>
              </button>

              <button
                id="btn-login-apple"
                type="button"
                onClick={() => handleSocialLogin('Apple')}
                className="flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold text-slate-700 dark:text-slate-200 transition-colors"
              >
                <img src="/assets/apple.png" alt="Apple" className="w-4 h-4 dark:invert" onError={(e) => { (e.target as HTMLElement).style.display = 'none'; }} />
                <span>Apple ID</span>
              </button>
            </div>
          </div>
        </div>

        {/* Sign Up Redirect */}
        <p className="text-center text-xs text-slate-600 dark:text-slate-400">
          Don't have a citizen account?{' '}
          <button
            id="btn-switch-to-signup"
            type="button"
            onClick={() => onNavigate('signup')}
            className="font-bold text-[#00695C] dark:text-[#00897B] hover:underline ml-1"
          >
            Sign Up
          </button>
        </p>

        {/* Demo Fast Login Banner */}
        <div className="text-center">
          <button
            id="btn-quick-demo-login"
            type="button"
            onClick={() => {
              StorageService.setCurrentUser(DEMO_USER);
              onLoginSuccess(DEMO_USER);
              onNavigate('home');
            }}
            className="inline-flex items-center gap-1.5 text-xs font-medium text-teal-700 dark:text-teal-400 hover:underline bg-teal-50 dark:bg-teal-950/40 px-3 py-1.5 rounded-full"
          >
            <Sparkles className="w-3.5 h-3.5" />
            <span>Instant Demo Access (Karthik Raja)</span>
          </button>
        </div>
      </div>

      {/* Forgot Password Modal */}
      {showForgotModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white dark:bg-[#1E1E1E] rounded-3xl p-6 max-w-sm w-full border border-slate-200 dark:border-slate-800 shadow-xl space-y-4">
            <h3 className="text-lg font-bold text-slate-900 dark:text-white">
              Reset Your Password
            </h3>
            <p className="text-xs text-slate-600 dark:text-slate-300">
              Enter the email address registered with your citizen account. We'll send you password recovery instructions.
            </p>

            {forgotSubmitted ? (
              <div className="p-4 rounded-2xl bg-emerald-50 text-emerald-800 text-xs flex items-start gap-2">
                <CheckCircle className="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" />
                <span>Password reset link has been dispatched to {forgotEmail}. Check your inbox.</span>
              </div>
            ) : (
              <div className="space-y-3">
                <input
                  type="email"
                  value={forgotEmail}
                  onChange={(e) => setForgotEmail(e.target.value)}
                  placeholder="name@example.com"
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:outline-none focus:border-[#00695C]"
                />
                <button
                  type="button"
                  onClick={() => {
                    if (forgotEmail) setForgotSubmitted(true);
                  }}
                  className="w-full py-2.5 rounded-xl bg-[#00695C] text-white text-xs font-semibold hover:bg-[#004D40]"
                >
                  Send Verification Link
                </button>
              </div>
            )}

            <button
              type="button"
              onClick={() => {
                setShowForgotModal(false);
                setForgotSubmitted(false);
              }}
              className="w-full text-xs font-medium text-slate-500 hover:text-slate-800 dark:hover:text-slate-200 pt-1"
            >
              Close
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
