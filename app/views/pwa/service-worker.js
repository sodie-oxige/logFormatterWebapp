self.addEventListener('fetch', function (e) {
  if(!/.(jpg|png)$/.test(e.request.url)) return;
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
