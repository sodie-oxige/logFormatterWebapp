const EXTENSIONS = [
  "jpg",
  "png",
  "ttf"
]
self.addEventListener('fetch', function (e) {
  if (!EXTENSIONS.includes(e.request.url.split(".").pop().toLowerCase())) return;
  e.respondWith(
    caches.open("images").then(function (cache) {
      return cache.match(e.request).then(function (response) {
        if (response) return response;
        return fetch(e.request).then(function (response) {
          if (response.ok) {
            cache.put(e.request, response.clone());
          }
          return response;
        });
      });
    })
  );
});
