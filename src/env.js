const ENV = window._env_ || {};

// Fallback to hardcoded process.env values for build-time variables
export const getEnv = (key, fallback = "") => {
  return ENV[key] || process.env[key] || fallback;
};