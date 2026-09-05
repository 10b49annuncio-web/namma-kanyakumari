import React, { useState, useEffect } from 'react';
import { ComplaintModel, ComplaintStatus, NotificationModel, ScreenRoute, UserModel } from './types';
import { StorageService } from './services/storage';
import { Navbar } from './components/Navbar';
import { BottomNav } from './components/BottomNav';
import { ComplaintDetailModal } from './components/ComplaintDetailModal';
import { SplashScreen } from './screens/SplashScreen';
import { OnboardingScreen } from './screens/OnboardingScreen';
import { LoginScreen } from './screens/LoginScreen';
import { SignupScreen } from './screens/SignupScreen';
import { HomeScreen } from './screens/HomeScreen';
import { ReportComplaintScreen } from './screens/ReportComplaintScreen';
import { ComplaintHistoryScreen } from './screens/ComplaintHistoryScreen';
import { EmergencyScreen } from './screens/EmergencyScreen';
import { GovServicesScreen } from './screens/GovServicesScreen';
import { TourismScreen } from './screens/TourismScreen';
import { NotificationsScreen } from './screens/NotificationsScreen';
import { ProfileScreen } from './screens/ProfileScreen';

export const App: React.FC = () => {
  const [currentScreen, setCurrentScreen] = useState<ScreenRoute>('splash');
  const [user, setUser] = useState<UserModel | null>(null);
  const [complaints, setComplaints] = useState<ComplaintModel[]>([]);
  const [notifications, setNotifications] = useState<NotificationModel[]>([]);
  const [selectedComplaint, setSelectedComplaint] = useState<ComplaintModel | null>(null);
  const [darkMode, setDarkMode] = useState<boolean>(false);
  const [language, setLanguage] = useState<'en' | 'ta'>('en');

  // Initial load
  useEffect(() => {
    const loadedUser = StorageService.getCurrentUser();
    const loadedComplaints = StorageService.getComplaints();
    const loadedNotifications = StorageService.getNotifications();
    const isDark = StorageService.isDarkMode();
    const lang = StorageService.getLanguage();

    setUser(loadedUser);
    setComplaints(loadedComplaints);
    setNotifications(loadedNotifications);
    setDarkMode(isDark);
    setLanguage(lang);

    if (isDark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, []);

  const handleToggleDarkMode = () => {
    const nextDark = !darkMode;
    setDarkMode(nextDark);
    StorageService.setDarkMode(nextDark);
    if (nextDark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  const handleToggleLanguage = () => {
    const nextLang = language === 'en' ? 'ta' : 'en';
    setLanguage(nextLang);
    StorageService.setLanguage(nextLang);
  };

  const handleNavigate = (route: ScreenRoute) => {
    setCurrentScreen(route);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleLoginSuccess = (loggedInUser: UserModel) => {
    setUser(loggedInUser);
    setCurrentScreen('home');
  };

  const handleLogout = () => {
    StorageService.setCurrentUser(null);
    setUser(null);
    setCurrentScreen('login');
  };

  const handleComplaintAdded = (newComplaint: ComplaintModel) => {
    setComplaints(prev => [newComplaint, ...prev]);
    setNotifications(StorageService.getNotifications());
  };

  const handleStatusChange = (complaintId: string, newStatus: ComplaintStatus) => {
    const updatedList = StorageService.updateComplaintStatus(complaintId, newStatus);
    setComplaints(updatedList);
    if (selectedComplaint && selectedComplaint.complaintId === complaintId) {
      setSelectedComplaint(prev => prev ? { ...prev, status: newStatus } : null);
    }
  };

  const unreadNotificationsCount = notifications.filter(n => !n.isRead).length;

  // Render full screen flows without chrome (Splash, Onboarding, Login, Signup)
  if (currentScreen === 'splash') {
    return <SplashScreen onNavigate={handleNavigate} />;
  }

  if (currentScreen === 'onboarding') {
    return <OnboardingScreen onNavigate={handleNavigate} />;
  }

  if (currentScreen === 'login') {
    return <LoginScreen onNavigate={handleNavigate} onLoginSuccess={handleLoginSuccess} />;
  }

  if (currentScreen === 'signup') {
    return <SignupScreen onNavigate={handleNavigate} onSignupSuccess={handleLoginSuccess} />;
  }

  // Main Application Shell with Navbar and Bottom Navigation
  return (
    <div className={`min-h-screen ${darkMode ? 'dark bg-[#121212] text-white' : 'bg-[#F8FAFC] text-[#1A1A1A]'} transition-colors duration-200 flex flex-col justify-between`}>
      {/* Top App Bar */}
      <Navbar
        currentScreen={currentScreen}
        onNavigate={handleNavigate}
        user={user}
        unreadCount={unreadNotificationsCount}
        darkMode={darkMode}
        onToggleDarkMode={handleToggleDarkMode}
        language={language}
        onToggleLanguage={handleToggleLanguage}
      />

      {/* Main Screen Container */}
      <main className="flex-1 max-w-4xl w-full mx-auto px-4 sm:px-6 pt-4 pb-20">
        {currentScreen === 'home' && (
          <HomeScreen
            user={user}
            complaints={complaints}
            onNavigate={handleNavigate}
            onViewDetails={(c) => setSelectedComplaint(c)}
            language={language}
          />
        )}

        {currentScreen === 'report_complaint' && (
          <ReportComplaintScreen
            user={user}
            onNavigate={handleNavigate}
            onComplaintAdded={handleComplaintAdded}
            language={language}
          />
        )}

        {currentScreen === 'complaint_history' && (
          <ComplaintHistoryScreen
            complaints={complaints}
            onNavigate={handleNavigate}
            onViewDetails={(c) => setSelectedComplaint(c)}
            language={language}
          />
        )}

        {currentScreen === 'emergency' && (
          <EmergencyScreen
            onNavigate={handleNavigate}
            language={language}
          />
        )}

        {currentScreen === 'government_services' && (
          <GovServicesScreen
            language={language}
          />
        )}

        {currentScreen === 'tourism' && (
          <TourismScreen
            language={language}
          />
        )}

        {currentScreen === 'notifications' && (
          <NotificationsScreen
            notifications={notifications}
            onNotificationsChange={setNotifications}
            complaints={complaints}
            onViewDetails={(c) => setSelectedComplaint(c)}
            language={language}
          />
        )}

        {currentScreen === 'profile' && (
          <ProfileScreen
            user={user}
            onUserUpdate={setUser}
            onNavigate={handleNavigate}
            onLogout={handleLogout}
            darkMode={darkMode}
            onToggleDarkMode={handleToggleDarkMode}
            language={language}
            onToggleLanguage={handleToggleLanguage}
          />
        )}
      </main>

      {/* Bottom Navigation */}
      <BottomNav
        currentScreen={currentScreen}
        onNavigate={handleNavigate}
        language={language}
      />

      {/* Complaint Detail & Stepper Timeline Modal */}
      {selectedComplaint && (
        <ComplaintDetailModal
          complaint={selectedComplaint}
          onClose={() => setSelectedComplaint(null)}
          onStatusChange={handleStatusChange}
        />
      )}
    </div>
  );
};
