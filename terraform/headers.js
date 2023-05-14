// function handler(event) {
//     const request = event.request;
//     const uri = request.uri;

//     if (uri.endsWith('.html')) {
//       const cleanUri = uri.slice(0, -5); // Remove the last 5 characters (.html)

//       return {
//         statusCode: 301,
//         statusDescription: 'Moved Permanently',
//         headers: {
//           location: {
//             value: `${request.headers.host[0].value}${cleanUri}`,
//           },
//         },
//       };
//     }

//     return request;
//   }

//   exports.handler = handler;
