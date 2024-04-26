'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "cb2e6df9df17b2e11ae9414920a62e8f",
"index.html": "8f5637915c9ce9c2c62916a6c3a1e455",
"/": "8f5637915c9ce9c2c62916a6c3a1e455",
"main.dart.js": "39e29b16697a53639b30c9f4e3872ace",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "3a65704b66d4c87b46f695b9fc05c96f",
"icons/Icon-192.png": "05cbd5b375be63fef34b602d6393ce0c",
"icons/Icon-maskable-192.png": "05cbd5b375be63fef34b602d6393ce0c",
"icons/Icon-maskable-512.png": "be2dad73cc6e59c4a86f554711019d46",
"icons/Icon-512.png": "be2dad73cc6e59c4a86f554711019d46",
"manifest.json": "e0d5e15dec1587407aedb8a487bfa2dd",
"assets/AssetManifest.json": "adab099eef27edf942fcd861d3df5e86",
"assets/NOTICES": "ec219e95850496c4a5f9cdc5ffa2f2e3",
"assets/FontManifest.json": "0b0990d879e8e194b317a0d4084b96cd",
"assets/AssetManifest.bin.json": "dbe3f357867fb13aac7aa8d8376d9e62",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "06bc8997d88fcdfefb452298dcef9b20",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "b8e5e5bf2b490d3576a9562f24395532",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "acdd567faa403388649e37ceb9adeb44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "37465c716c1824c04da1f247dc55b083",
"assets/fonts/MaterialIcons-Regular.otf": "d23b4f7829bbac2d2f68ad6c5dcec21c",
"assets/assets/images/transfer_1.png": "385c1964df169ba9e1717cd489f9442f",
"assets/assets/images/icon16.png": "06b346cfeebf3e779f748373e0232a08",
"assets/assets/images/googleplay.png": "e1021cf464b25a2e67ca2b5358e3634b",
"assets/assets/images/transfer_2.png": "2ee80e53c2c52d8039c16ad4df40697c",
"assets/assets/images/telegram.png": "974b22299a81a7315ba646ab481c2524",
"assets/assets/images/icon.png": "518452496623bc8c3e823f60ac8e4abb",
"assets/assets/images/instagram.png": "451bf1984847df8acfd5af5e875902f7",
"assets/assets/images/ic_app_store.png": "942f79763feecbb3a7348a763659bca3",
"assets/assets/images/logo128.png": "61f0fef6bc57ecfea4308cf311e9a1fc",
"assets/assets/images/logo1080.png": "99cdb6a99a58c9d853b963909e514e48",
"assets/assets/images/youtube.png": "fe778025e635687761935188df7c0757",
"assets/assets/images/whatsapp.png": "04d1c2280178579fc3cd8ff9de6e190e",
"assets/assets/images/facebook.png": "722015e7e155a40a46d636d3e230a8be",
"assets/assets/images/ic_play_store.png": "0fe4390ba31f92bcd9facaf0585e8067",
"assets/assets/fonts/Outfit-Bold.ttf": "2960062c0977e0bbf1b8c600053f8125",
"assets/assets/fonts/Outfit-Regular.ttf": "55c9ece0a0c8820c818f4664c8ce72ae",
"assets/assets/fonts/Outfit-Medium.ttf": "f10848bb47ef68b5a90b8c3a6aecdadc",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
