'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "97f08f8e4a00db3dd3c56348773148a9",
"version.json": "79fcdfeb8eaa23e60ed69f2000b67e91",
"index.html": "9f0757a513583db4cdbe966bf2b8aca1",
"/": "9f0757a513583db4cdbe966bf2b8aca1",
"main.dart.js": "6cdb8657ed61e927272af23c116b1c0f",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "2ae0721e52f740644d410c17aa8cf242",
"assets/AssetManifest.json": "068f906bbf63e090360fde829f25cb39",
"assets/NOTICES": "13ea53fc7116be5d1cd9f82b9085cc78",
"assets/FontManifest.json": "5fad27ccac28dcea27cf92f4dd43187b",
"assets/AssetManifest.bin.json": "f8da639918d517480fe7c7b5b9b3b219",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "391ff5f9f24097f4f6e4406690a06243",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "070edda27bfa2fe812b2308c68bf6473",
"assets/fonts/MaterialIcons-Regular.otf": "5ddfd60c3e8f4098775f334979217064",
"assets/assets/images/4icon.png": "6c4194c9944e42dd79c2ec61e97366c1",
"assets/assets/images/sokszin.png": "d699acaa429d0affc0d6682ca36ed9fe",
"assets/assets/images/3-4-karkoto.png": "f03bd87ae9cce7a02376d0fa4525eec5",
"assets/assets/images/bethesda_white_logo_name.png": "74cba65aa85322478b2f020870705d57",
"assets/assets/images/5icon_m.png": "bdd7379501e865ce94d12fe833b168fa",
"assets/assets/images/bethesda_gyerm_logo_nevvel.png": "0065eb4779d971db517abb72455135c7",
"assets/assets/images/7-8.png": "a862038c7584501f129fb83a73790063",
"assets/assets/images/fox-horizontal-nobackground_2.png": "65bd560bf96aeda3c17642889f12650b",
"assets/assets/images/6icon_b.png": "532cdfbda4d990f0f22daea685b89203",
"assets/assets/images/3icon_m.png": "52be48cfdfb3c29507414a603beef312",
"assets/assets/images/5icon.png": "ba3728a6801f75c784db255633f98e6e",
"assets/assets/images/probaelsohatter.png": "251afb988e15a4c5ccc101490004ecd8",
"assets/assets/images/hatter.jpg": "95aae4ecbd25746c61f4484de9ef3a01",
"assets/assets/images/biztonsagoshely.jpg": "b45a926865d3695777b1d6184dd4c0fb",
"assets/assets/images/7icon.png": "3d855abf25542a20a207766a70ec2949",
"assets/assets/images/bear_nobackground.png": "1cc24debfaa18020de52725e0c9bc7c6",
"assets/assets/images/4icon_m.png": "e448584e4311ba2a6311ec6c050fcd32",
"assets/assets/images/1icon_b.png": "92a7a3bdf7d78929262a7d6cdb0e6340",
"assets/assets/images/6icon.png": "1858ad8ef4028504e288d9c1f7d776e0",
"assets/assets/images/9tLs.gif": "40b6d7a5ff035bd26423057b02a4ab52",
"assets/assets/images/sokszin.svg": "38f66515f92b41e6d873858728a24716",
"assets/assets/images/gyakorlat1.jpg": "7166573ae8ccc40139c0b9f665e5865a",
"assets/assets/images/ka.png": "3797940542b9dde95ec69891b87e7b53",
"assets/assets/images/bethesda_gyermekkorhaz_logo.png": "be45d6ac5e3a182bc0913cf7abe7314c",
"assets/assets/images/2icon_m.png": "42d668df70494410c503fdfb96074bee",
"assets/assets/images/bethesda_logo_nobackground.png": "3b5b684dd2f9ab4d5491533ddd35dd03",
"assets/assets/images/7icon_b.png": "cf3dcbd52889001bbdb2a1a708d52888",
"assets/assets/images/gyakorlat2.jpg": "2aaadcd53140590e5621bf15187a5123",
"assets/assets/images/fox_nobackground.png": "c1d1dd99d33dd29fc070a7f5f6b6ad8d",
"assets/assets/images/szines.png": "115e635ed63853234f3ad6c2eb0a332d",
"assets/assets/images/major_janos.png": "7a32e5a2b4790ae92c93cf03ec764316",
"assets/assets/images/szines_2.png": "304bf2595414f40df7ffcb3f8c2de4db",
"assets/assets/images/2icon_b.png": "f4528e787b0330a1b7c6b57cf2e50f55",
"assets/assets/images/reg.svg": "91b076ce15082e4f4c78cf8df601dd72",
"assets/assets/images/7icon_m.png": "ce10c00354320c74f38e464923e5a7c5",
"assets/assets/images/3icon.png": "5a69f0478161dbd2144d4896dcd32603",
"assets/assets/images/fox-horizontal-nobackground.png": "f267171377243f51ff87df047f2ea966",
"assets/assets/images/m3hatter_kicsi%2520(2).svg": "cd58d378165ff54e8b579f4a7598dd85",
"assets/assets/images/2icon.png": "81ce6cd312249e5fd839c4b6435f06f1",
"assets/assets/images/3-4rainbow.png": "1fd5d0ec96edbc729a2a8eeef3d83f0b",
"assets/assets/images/bear_up_nobackground.png": "8c5bd68d91bb423e9fc197f17f83c17c",
"assets/assets/images/relaxnagy.jpg": "bb1f69c7af35e5ecf8568c06cabf0139",
"assets/assets/images/4icon_b.png": "5aaa4de374244cbaa9c5ec52a09482d9",
"assets/assets/images/1icon_m.png": "750e5484b1b942e05526cd3df8b9c9ef",
"assets/assets/images/ordogikor.png": "10811c657442b72dd963570727f7a731",
"assets/assets/images/nyil.json": "77d3322f74de66183cf790e6f7e0aeae",
"assets/assets/images/5-6tengerpart.jpg": "27fa3a75657a781f1f0b67c65be17b8c",
"assets/assets/images/m3hatter.svg": "be78b22eeab3393997584fab463c4abb",
"assets/assets/images/6icon_m.png": "4fbc0cee4c497e563bb92fb5eb46a214",
"assets/assets/images/fox.png": "a589142ce4b945343fb117b4b5549eaa",
"assets/assets/images/3icon_b.png": "094f689b2a4b56b530f27a134731b39c",
"assets/assets/images/hatterke.png": "c99d822af5e6cc8505073805449f89d7",
"assets/assets/images/szines-nohatter.png": "3651184048e40964ca3a0aabc012383c",
"assets/assets/images/bear.png": "b9597a02af641beb213e8560bb8fe6cf",
"assets/assets/images/1icon.png": "5ea50e3340ec0f5f417e284038b7be08",
"assets/assets/images/5-6tengerpart_2.png": "01cc03501556bc0d8d6525e6e8f79021",
"assets/assets/images/5icon_b.png": "8b42cb9db4b9b654c0673327e444111f",
"assets/assets/html/audio_player.html": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/Montserrat/static/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
