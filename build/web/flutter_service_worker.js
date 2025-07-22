'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e2d6dd2a650f46ced6c25ffddb90c28c",
"assets/AssetManifest.bin.json": "f475bf4b51736974dcc221daf5ecf069",
"assets/AssetManifest.json": "1579711168bae62fea45a5e4f9dc77dd",
"assets/assets/app/ic_launcher-android.png": "d51cdc4311f4bc1c6b6ee87692f76d34",
"assets/assets/app/ic_launcher.png": "d51cdc4311f4bc1c6b6ee87692f76d34",
"assets/assets/app/logo_splash.png": "b79da8f54eb22e4597005cc5cd6c16f5",
"assets/assets/app/logo_splash_bottom.png": "71f07039da2bb8c2ac44254e64404c90",
"assets/assets/images/audiotrack_resource.png": "67eeb42d7d735b6fb741ca3f0bf468b5",
"assets/assets/images/banner.png": "19e19e82fad814837064593225237272",
"assets/assets/images/books.svg": "db50ce6285a6a54c877dbbb9aac335ec",
"assets/assets/images/books.ttf": "3ebfaad95ecd8fce223d9770839cdb42",
"assets/assets/images/Brands.png": "9be0c8c24a2c079031765e0a28230236",
"assets/assets/images/button_click.png": "774689dfc0c496cca7fe9d51aef7e970",
"assets/assets/images/button_play.png": "215b5292394f8c73e7fe4130dee77132",
"assets/assets/images/calendar.png": "212c8f8055015e8f1a295033cd48b9d4",
"assets/assets/images/curso.svg": "efcdda161bd082304b976ede543ed38b",
"assets/assets/images/download-finished.png": "171073c7cec146e405e07fecc1371ce3",
"assets/assets/images/download.png": "a90058cee3fe9516cb615bff4bf2402e",
"assets/assets/images/downloading.png": "815423b2d62b3fe6d3e0bce3e79c4d6a",
"assets/assets/images/Ebook.png": "73151264d331cc3bc09e54b35006e80a",
"assets/assets/images/ebook_resource.png": "51fa1795fd48fdf42cc6cf1b7bd45c81",
"assets/assets/images/favoritar.png": "16442453ff7aa67e6026164134beeea4",
"assets/assets/images/favoritarfillicon.png": "a1c30e7babeece72b031b8806423aebf",
"assets/assets/images/game_case.png": "f563b3935ccfc1c7da955e2907d758b2",
"assets/assets/images/game_case_resource.png": "3761d340b51f94f8c7464378d318cf5f",
"assets/assets/images/global-line.png": "f5c81670524c794458fcb7c84f685240",
"assets/assets/images/google.png": "16597b58fb4d4fa8ebcf5a013fc19b0a",
"assets/assets/images/Group.png": "90de03a66ecf270798b652525f7adc58",
"assets/assets/images/haze-line.png": "2ff1073d63760ab9cdd1a7472eff3472",
"assets/assets/images/heart-fill.png": "ebc43627596194c710c9e935838bbea0",
"assets/assets/images/home.svg": "5bea1e70e19cdd34fd9dad9230a31b5c",
"assets/assets/images/Infografico.png": "34da135a807fa930dc60e32c30d5941d",
"assets/assets/images/infographic_resource.png": "5e58a12650cd6d105216f6fb72e209f0",
"assets/assets/images/informacao.png": "300ba1bacd298e61227bcc7dc63e9f6b",
"assets/assets/images/like-fill.png": "768839bbaf87301adb7c219719428df1",
"assets/assets/images/like.png": "e277d939042d7d8d32edde272721e8aa",
"assets/assets/images/logo_biblioteca.png": "4a9d98736a7bc719b70768c6abd53a3c",
"assets/assets/images/media.png": "4bc1dc6d29ad040b664d975ee6e0b0f0",
"assets/assets/images/multimidia_resource.png": "0c64a71c68b9e857968ccdbb9b4e0b8b",
"assets/assets/images/pdf.png": "f994976344e961932376ba0f5e975953",
"assets/assets/images/pdf_resource.png": "a90e7a629055fc936826fcce114ac9f9",
"assets/assets/images/perfil.svg": "315092a7f73a20f8952a56cdf7e867d1",
"assets/assets/images/podcast.png": "ad3405ab26d5c2d4b8aac7fde8c16bfe",
"assets/assets/images/profile.png": "de615d1010040c458ac0d7337298c2ef",
"assets/assets/images/recurso_multimidia.png": "2e0d53416cd73a44bd2096aea37e141c",
"assets/assets/images/search.svg": "b607d6fb149e07a0cd814c854f00439d",
"assets/assets/images/share.png": "9a87b2323004d6fa5bb18708c9424e04",
"assets/assets/images/siren-fill.png": "90de03a66ecf270798b652525f7adc58",
"assets/assets/images/star.png": "1f4bd5819693cc7b8f0b036399002cfd",
"assets/assets/images/starAvaliation.png": "ce6bc778e30316528f211ae7a3279668",
"assets/assets/images/starAvaliationNotFill.png": "47771227ffcd54d192cb0e571be3fc8d",
"assets/assets/images/ver_mais.png": "42920fccd780032d1ab33ca385c8d64d",
"assets/assets/images/video_resource.png": "b70af7969ad6d89dcdbe856ab8dccb3f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b684465d24a9f8702099681c74a96bd0",
"assets/NOTICES": "83dd563e231805de8d1d98420d9c7256",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d7d83bd9ee909f8a9b348f56ca7b68c6",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "ea18a9197670143b9b492747100cc788",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "f19d14b0c965b6612165e3a07d54772b",
"icons/Icon-192.png": "69cfcdb3dba242fbc82c3d3137035f4e",
"icons/Icon-512.png": "cba2b5fe3598fb46b8db5a85868de4d4",
"icons/Icon-maskable-192.png": "69cfcdb3dba242fbc82c3d3137035f4e",
"icons/Icon-maskable-512.png": "cba2b5fe3598fb46b8db5a85868de4d4",
"index.html": "ea652383bba235f320d83401ce4f0ecd",
"/": "ea652383bba235f320d83401ce4f0ecd",
"main.dart.js": "4431dd45fbb90626e49828916851d804",
"manifest.json": "6e6d5630158b1eed3eda8aac53c18526",
"version.json": "2f6f03cec8163feb3f8c5d8ba89f5a32"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
