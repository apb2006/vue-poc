"use strict";
importScripts('https://storage.googleapis.com/workbox-cdn/releases/3.4.1/workbox-sw.js');

if (workbox) {
  console.log(`Yay! Workbox is loaded 🎉`);
  
  workbox.setConfig({
    debug: false
  });
  
//Shows logs, warnings and errors.
  workbox.core.setLogLevel(workbox.core.LOG_LEVELS.log);

  workbox.core.setCacheNameDetails({
    prefix: 'vue-poc',
    suffix: 'v1',
    precache: 'install-time',
    runtime: 'run-time',
    googleAnalytics: 'ga',
  });

  workbox.routing.registerRoute(
      new RegExp('/vue-poc/api/'),
      workbox.strategies.networkOnly()
    );
  
  workbox.routing.registerRoute(
      new RegExp('.*'),
      workbox.strategies.staleWhileRevalidate()
    );
  
} else {
  console.log(`Boo! Workbox didn't load 😬`);
};


