

;(function() {

	var JSBridgeName = '%@',
		JSBridgeProcotol = '%@',
		createIframe = function() {
			var iframe = document.createElement('iframe');
	        iframe.style.display = 'none';
			iframe.onload = function() {
				iframe.parentNode.removeChild(iframe);
			};
			return iframe;
		};
	window[JSBridgeName] = {
		

		request: function() {

	        var iframe = createIframe();

  			var args = Array.prototype.slice.apply(arguments),
  				random = parseInt(Math.random() * 1000000000000 + 1000000000000);
  			var name = '', params = null, callback = '';
  			if (args[0] && args[0].constructor == String) {
  				name = args.shift();
  			}
  			if (args[0] && typeof(args[0]) == "object" && Object.prototype.toString.call(args[0]).toLowerCase() == "[object object]" && !args[0].length) {
  				params = args.shift();
			}
			if (args[0] && args[0].constructor == Function) {
				var callbackFunction = args.shift();
				callback = 'CALLBACK' + random;
				window[callback] = callbackFunction;
			}

			var options = {
				type: 'function',
				name: name,
				args: params,
				callback: callback
			};
			iframe.src = JSBridgeProcotol + encodeURIComponent(JSON.stringify(options));
	        document.documentElement.appendChild(iframe);
		}
	};

	// create bridge onReady;
	var e = document.createEvent('Event');
	e.initEvent('MALLJSBridgeReady', false, false);
	document.dispatchEvent(e);

})();