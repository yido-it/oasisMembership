// Cache name
var CACHE_NAME = 'myCache';

// Files required to make this app work offline
var REQUIRED_FILES = [
	'/main'
];

self.addEventListener('install', function(event) {
	console.log('[Service Worker] Installing Service Worker ...');
	// Perform install step:  loading each required file into cache
	event.waitUntil(
		caches.open(CACHE_NAME)
			.then(function(cache) {
				// Add all offline dependencies to the cache
				return cache.addAll(REQUIRED_FILES);
			})
			.then(function() {
				return self.skipWaiting();
			})
	);
});

self.addEventListener('fetch', function(event) {
	event.respondWith(
		caches.match(event.request)
			.then(function(response) {
				/*
				// 캐시된 리소스 반환
				if (response) {
					console.log('캐시된 리소스 반환' + response);
					return response;
				}
				// 서버에서 리소스 반환
				console.log('서버에서 리소스 반환' + event.request);
				return fetch(event.request);
				*/				
				
				// 오프라인인 경우에만 캐시 리소스 반환
				if(!navigator.onLine) {
					return caches.match(event.request);
				} else {
					return fetch(event.request);
				}
				
			})
	);
});

self.addEventListener('activate', function(event) {
	console.log('[Service Worker] Activating Service Worker ...');
	// Calling claim() to force a "controllerchange" event on navigator.serviceWorker
	event.waitUntil(self.clients.claim());
});
