

var vues = {};

// Ajax = function(configs) {
// 	var defaults = {
// 		type: 'GET',
// 		url: '',
// 		waiting: '',
// 		data: {},
// 		success: null,
// 		error: null,
// 		complete: null
// 	},
// 	options = {};
// 	for (var i in defaults) {
// 		options[i] = configs.hasOwnProperty(i) ? configs[i] : defaults[i];
// 	}
// 	var j2p = function(json) { 
// 		var a = []; 
// 		for (var i in json) a.push(i + '=' + json[i]); 
// 		return a.join('&'); 
// 	};
// 	var random = parseInt(Math.random() * 1000000000000 + 1000000000000);
// 	this.successName = '';
// 	this.errorName = '';
// 	this.completeName = '';
// 	var self = this;
// 	// if (options.success) {
// 		this.successName = 'APP_CALLBACK_SUCCESS_' + random;
// 		window[this.successName] = function(response) {
// 			if (typeof response == 'string') {
// 				response = JSON.parse(response);
// 			}
// 			self.successResponse = response;
// 			options.success && options.success.call(window, response);
// 		};
// 	// }
// 	// if (options.error) {
// 		this.errorName = 'APP_CALLBACK_ERROR_' + random;
// 		window[this.errorName] = function(response) {
// 			self.errorResponse = response;
// 			options.error && options.error.call(window);
// 		};
// 	// }
// 	// if (options.complete) {
// 		this.completeName = 'APP_CALLBACK_COMPLETE_' + random;
// 		window[this.completeName] = function() {
// 			options.complete && options.complete(window);
// 		};
// 	// }

// 	var params = {
// 		type: options.type.toUpperCase(),
// 		url: options.url,
// 		waiting: options.waiting,
// 		data: j2p(options.data),
// 		success: this.successName,
// 		error: this.errorName,
// 		complete: this.completeName
// 	};
	
// 	// app._callMethod('ajax', JSON.stringify(params));
// 	$.ajax(params)
// };

// $.extend(Ajax.prototype, {
// 	then: function(successFunction, errorFunction) {
// 		if (successFunction) {

// 			this.successName && this.successName(this.successResponse);
// 		}
// 		if (errorFunction) {

// 			this.errorName && this.errorName(this.errorResponse);
// 		}
// 	},
// 	always: function(completeFunction) {

// 		if (completeFunction) {

// 			this.completeName && this.completeName(this.successResponse);
// 		}
// 	}

// });


// app接口
window.app = {
	_hasMethod: function(name) {
		return !!window['MallJSBridge'] && !!window['MallJSBridge'][name];
	},
	_callMethod: function(name) {
		if (!this._hasMethod(name)) {
			return;
		}
		return window['MallJSBridge'][name].apply(window['MallJSBridge'], Array.prototype.slice.call(arguments).slice(1));
	},
	showWaiting: function(message) {
		return this._callMethod('ShowWaiting', message);
	},
	// ajax: function(configs) {
	// 	console.log(configs)
	// 	return new Ajax(configs);
		
	// },
	openUpload: function(configs) {
		var defaults = {
			url: '',
			waiting: '',
			// 最大边长
			maxwidth: 0,

			// 图片质量 0-100
			quality: 100,

			dataType: 'json',
			params: {},
			start: null,
			cancel: null,
			success: null,
			error: null,
			complete: null
		},
		options = {};
		for (var i in defaults) {
			options[i] = configs.hasOwnProperty(i) ? configs[i] : defaults[i];
		}
		var j2p = function(json) { 
			var a = []; 
			for (var i in json) a.push(i + '=' + json[i]); 
			return a.join('&'); 
		};
		var random = parseInt(Math.random() * 1000000000000 + 1000000000000);
		var start = '', cancel = '', success = '', error = '', complete = '';
		if (options.start) {
			start = 'APP_UPLOAD_CALLBACK_START_' + random;
			window[start] = function() {
				options.start && options.start(window);
			};
		}
		if (options.cancel) {
			cancel = 'APP_UPLOAD_CALLBACK_CANCEL_' + random;
			window[cancel] = function() {
				options.cancel && options.cancel(window);
			};
		}
		if (options.complete) {
			complete = 'APP_UPLOAD_CALLBACK_COMPLETE_' + random;
			window[complete] = function() {
				options.complete && options.complete(window);
			};
		}
		if (options.success) {
			success = 'APP_UPLOAD_CALLBACK_SUCCESS_' + random;
			window[success] = function(response) {
				if (options.dataType == 'json' && typeof response !== 'object') {
					response = JSON.parse(response);
				}
				else if (options.dataType == 'text') {
					if (typeof response == 'object') {
						response = JSON.stringify(response);
					}
				}
				options.success && options.success.call(window, response);
			};
		}
		if (options.error) {
			error = 'APP_UPLOAD_CALLBACK_ERROR_' + random;
			window[error] = function(response) {
				if (options.dataType == 'json' && typeof response !== 'object') {
					response = JSON.parse(response);
				}
				else if (options.dataType == 'text') {
					if (typeof response == 'object') {
						response = JSON.stringify(response);
					}
				}
				options.error && options.error.call(window, response);
			};
		}
		if (options.complete) {
			complete = 'APP_CALLBACK_COMPLETE_' + random;
			window[complete] = function() {
				options.complete && options.complete(window);
			};
		}

		var params = {
			url: options.url,
			waiting: options.waiting,
			params: j2p(options.params),
			maxwidth: options.maxwidth,
			quality: options.quality,
			start: start,
			cancel: cancel,
			success: success,
			error: error,
			complete: complete
		};
		this._callMethod('openUpload', JSON.stringify(params));
	}

};


$.extend($, {
	/**
	 * 获取地址栏参数信息
	 * @param  {string} search ?xxx=1&mmm=3
	 * @param  {string} hash   #aaa=1&bbb=1
	 * @return {json}        {search: {xxx: 1, mmm: 3}, hash: {aaa: 1, bbb: 1}}
	 */
	params: function(search, hash){  
        search  = search    || window.location.search;  
        hash    = hash      || window.location.hash;  
          
        var fn = function(str, reg){  
            if(str){  
                var data = {};  
                str.replace(reg,function( $0, $1, $2, $3 ){  
                    data[ $1 ] = $3;  
                });  
                return data;  
            }  
        }  
          
        return {  
            search: fn(search,  new RegExp( "([^?=&]+)(=([^&]*))?", "g" ))||{},  
            hash:   fn(hash,    new RegExp( "([^#=&]+)(=([^&]*))?", "g" ))||{}  
        };  
    }
});


/** 页面初始化控制器 */
var page = {
	events: {},
	exit: function() {
		this.exitEvents = true;
	},
	execute: function(id) {
		typeof this.events[id] == 'function' && this.events[id]();
	},
	ready: function() {
		for (var i in this.events) {
			if (!this.exitEvents && this.events[i] && typeof this.events[i] == 'function') {
				this.events[i]();
			}
		}
	},
	push: function() {
		var id = typeof arguments[0] == 'function' ? parseInt(Math.random() * (999999 - 100000 + 1) + 100000) : arguments[0];
		var fn = typeof arguments[1] == 'function' ? arguments[1] : arguments[0];
		this.events[id] = fn;
		return id;
	}
	
};


var api = {
	domain: 'http://192.168.0.103:7021',
	getToken: function() {
		return '8237C82CC50EED56A4E46190338BCBB83C9A3D32EC554273F006ED66FE1F1A4C';
	},
	ajax: function(conf) {
		return $.ajax(conf).fail(function(response) {
			Toast(Mustache.render('Status: {{status}}', response));
		});
	},
	goods: function(id) {
		return this.ajax({
			type: 'GET',
			url: this.domain + '/api/goods/get',
			data: {
				access_token: this.getToken(),
				goods_id: id
			}
		});
	},
	favoriteAdd: function(id) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/favorite/add',
			data: {
				access_token: this.getToken(),
				goods_id: id
			}
		});

	},
	favoriteRemove: function(id) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/favorite/remove',
			data: {
				access_token: this.getToken(),
				goods_id: id
			}
		});

	},
	favoriteExist: function(id) {
		return this.ajax({
			url: this.domain + '/api/favorite/exist',
			data: {
				access_token: this.getToken(),
				goods_id: id
			}
		});

	}
}

document.addEventListener('MallJSBridgeReady', function() {
	page.ready();

}, false);

var j2p = function(json) {
	var a = [];
	for (var i in json) a.push(i + '=' + encodeURIComponent(json[i]));
	return a.join('&');
};

var parseData = function() {
	var args = Array.prototype.slice.apply(arguments);
	var data = {};
	$.each(args, function() {
		$.extend(data, this);
	});
	return j2p(data);
};

function Toast(options) {

	if (typeof options == 'string') {
		options = {
			content: options
		};
	}

	var options = $.extend({}, {
		theme: '',
		content: '',
		time: 3000
	}, options);

	var $wrap = $('<div class="Toast"><div class="panel">' + options.content + '</div></div>');
	$wrap.addClass(options.theme);
	$('body').append($wrap);

	window.setTimeout(function() {
		$wrap.remove();
	}, options.time);
}


// 幻灯片
function Slider(options) {
	this.init(options);
}

$.extend(Slider.prototype, {
	init: function(options) {
		this.options = $.extend({}, {
			conversion: 0.375,		// 宽高比 wraperHeight = wraperWidth * conversion;
			current: 1,
			speed: 300
		}, options);
	
		this.$wraper = $('#busSliderWraper');
		this.$slider = $('#busSlider');
		this.$control = $('#busSliderControl');
		
		this.setWraperSize();
		
		this.request();
	},
	request: function() {
		var _this = this;
		_this.render();
		// if (sessionStorage.getItem('slideinfo')) {
		// 	_this.data = JSON.parse(sessionStorage.getItem('slideinfo')) || [];
		// 	_this.render();
		// }
		// else {
		// 	$.ajax({
		// 		url: $.host.main + 'Common/SlideInfos?webId=' + _this.options.webid,
		// 		dataType: 'jsonp',
		// 		success: function(data) {
		// 			_this.data = data || [];
		// 			sessionStorage.setItem('slideinfo', JSON.stringify(data));
		// 			_this.render();
		// 		}
		// 	});
		// }

	},
	render: function() {
		var _this = this, options = _this.options, content = '', controls = '';

		// $.each(_this.data, function(i) {
		// 	content += _this.cell(this);
		// 	controls += '<em></em>';
		// });
		// _this.$slider.html(content);
		// _this.$control.html(controls);
		
		_this.$cells = _this.$slider.find('.bus-slider-cell');
		_this.length = _this.$cells.size();

		var $first = _this.$cells.first().clone();
		var $last = _this.$cells.last().clone();
		
		_this.$cells.first().before($last.addClass('duplicate'));
		_this.$slider.append($first.addClass('duplicate'))
		_this.bindEvents();
	},
	cell: function(d) {
		return ['<a class="bus-slider-cell" href="', d.InfoIdentity, '">',
					'<img src="', d.ImgUrl, '">',
				'</a>'].join('');
	},
	bindEvents: function() {
		var _this = this, options = _this.options;

		_this.setCurrent();
		_this.setSliderTransform(- (_this.screenWidth * options.current));
	
		// slider 尺寸
		$(window).resize(function() {
			_this.setWraperSize();
			_this.setSliderTransform(- (_this.screenWidth * options.current));
		});
	
		// 滑动
		_this.$wraper.on('touchstart', function(e) {
			_this.touchstart(e);
		});
		_this.$wraper.on('touchmove', function(e) {
			_this.touchmove(e);
		});
		_this.$wraper.on('touchend', function() {
			_this.touchend();
		});
		_this.auto();
		
		_this.$wraper.removeClass('bus-slider-wraper-loading');
	},
	touchstart: function(e) {
		if (!e.originalEvent.touches.length) return;
		var touch = e.originalEvent.touches[0];
		this.touchStartX = touch.pageX;
		this.touchMoveX = touch.pageX;
		this.setSliderTransition(0);
		this.setSliderTransform(- (this.screenWidth * this.options.current));
		this.touchTime = new Date();
		this.positionX = this.getSliderTransform();
		this.autoStop();
	},
	touchmove: function(e) {
		if (e.originalEvent.type === 'touchmove') {
			e.preventDefault();
		}
		if (!e.originalEvent.touches.length) return;
		var touch = e.originalEvent.touches[0];
		this.touchMoveX = touch.pageX;
		// document.querySelector('#busList').innerHTML += this.touchMoveX + ',,' + this.touchStartX + '<br>';

		if (!this.scrolling) {
			var x = this.touchMoveX - this.touchStartX;
			this.setSliderTransform(x + this.positionX);
		}
	},
	touchend: function() {
		var options = this.options, x = this.touchMoveX - this.touchStartX;
		var current = options.current;
		var date = new Date();

		var left = x > 25;
		var right = x < -25;

		var span = Math.abs(x) || 0;
		// document.querySelector('#busList').innerHTML += 'touchMoveX:' + this.touchMoveX + ', touchStartX:' + this.touchStartX + '<br>';
		// document.querySelector('#busList').innerHTML += 'span: ' +span + ', time:' + (date - this.touchTime) + '<br>';
		if (span < 30 && (date - this.touchTime) < 100) {
			// document.querySelector('#busList').innerHTML += 'return<br>';
			this.auto();
			return;
		}

		if (left) {
			if (this.isFirst) {
				this.setCurrent(this.length);
				current = 0;
			}
			else {
				this.setCurrent(current -= 1);
			}
		}
		else if (right) {
			if (this.isLast) {
				this.setCurrent(1);
				current += 1;
			}
			else {
				this.setCurrent(current += 1);
			}
		}
	
		this.setSliderTransition(options.speed);
		this.setSliderTransform(- (this.screenWidth * current));
	
		this.scrollEnd();
		this.auto();
	},
	scrollEnd: function() {
		var _this = this;
		_this.scrolling = true;
		window.clearTimeout(_this.scrollingTimer);
		_this.scrollingTimer = window.setTimeout(function() {

			// 滚动中状态，不允许touchmove事件设置transform
			_this.scrolling = false;
			
			// 重置幻灯片位置，如果当前是复制体的画面，设置到真实画面
			_this.setSliderTransition(0);
			_this.setSliderTransform(- (_this.screenWidth * _this.options.current));
		}, this.options.speed);
	},
	setSliderTransition: function(duration) {
		var style = this.$slider.get(0).style;
		style.webkitTransitionDuration = duration / 1000 + 's';
	},
	setSliderTransform: function(x, y, z) {
		var style = this.$slider.get(0).style;
		var x = x || 0, y = y || 0, z = z || 0;
		style.webkitTransform = 'translate3d(' + x + 'px, ' + y + 'px, ' + z + 'px)';
	},
	getSliderTransform: function() {
		var style = this.$slider.get(0).style;
		var matrix = new WebKitCSSMatrix(style.webkitTransform);
		return matrix.m41;
	},
	setCurrent: function(current) {
		var options = this.options, current = current === undefined ? options.current : current;
		options.current = current;
		this.isFirst = options.current <= 1 ? true : false;
		this.isLast = options.current >= this.length ? true : false;
		this.$control.find('em').eq(options.current - 1).addClass('current').siblings().removeClass('current');
	},
	setWraperSize: function() {
		this.screenWidth = $(window).width();
		this.$wraper.css({width: this.screenWidth, height: this.screenWidth * this.options.conversion});
	},
	next: function() {
		var _this = this, options = this.options;
		var current = options.current;
		if (this.isLast) {
			this.setCurrent(1);
			current += 1;
		}
		else {
			this.setCurrent(current += 1);
		}

		_this.setSliderTransition(options.speed);
		_this.setSliderTransform(- (_this.screenWidth * current));

		_this.scrollEnd();
		
	},
	auto: function() {
		var _this = this;
		
		if (_this.length <= 0) return;
		
		_this.autoStop();

		_this.timer = window.setTimeout(function() {
			_this.auto();
			_this.next();
		}, 4000);
	},
	autoStop: function() {
		window.clearTimeout(this.timer);
	}

});

// ngApp.controller('PageOrders', function($rootScope, $scope) {

// 	$scope.tab = 1;

// 	var pScroll = new IScroll($('.goods').get(0), {
// 		snap: true,
// 		scrollX: true,
// 		scrollY: false,
// 		mouseWheel: true
// 	});
// 	$scope.$on('ngRepeatFinished', function(ngRepeatFinishedEvent) {
		
		
// 	});

// });

// ngApp.controller('PageOrderConfirm', function($rootScope, $scope) {

// 	$scope.payment = 'wechat';

// });
// ngApp.controller('PageCart', function($rootScope, $scope) {

// 	$('.num').each(function() {
// 		var $this = $(this),
// 			$addition = $this.find('.icon-addition'),
// 			$reduced = $this.find('.icon-reduced'),
// 			$num = $this.find('b');


// 	});

// 	$scope.reduced = function($event) {
// 		var target = $event.currentTarget;
// 		var $target = $(target);

// 		var $num = $target.next();

// 		var n = $num.html();
// 		if (n == 1) {
// 			console.log('do delete');
// 			return;
// 		}

// 		n = parseInt(n) - 1;
// 		$num.html(n);

// 		if (n == 1) {
// 			$target.addClass('disabled');
// 		}
// 	};

// 	$scope.addition = function($event) {
// 		var target = $event.currentTarget;
// 		var $target = $(target);
// 		if ($target.hasClass('disabled')) {
// 			return;
// 		}
// 		var $num = $target.prev();

// 		var n = $num.html();

// 		n = parseInt(n) + 1;
// 		$num.html(n);

// 		if (n > 1) {
// 			$num.prev().removeClass('disabled');
// 		}

// 	};

// });

// ngApp.controller('PageGoodsDetail', function($rootScope, $scope, $api) {
	

// 	$api.favoriteExist(1).then(function(response) {

// 	}, function() {

// 	});




// });

// ngApp.controller('PageInvitation', function($rootScope, $scope) {
	
// });

// ngApp.controller('PageCommentView', function($rootScope, $scope) {
	
// 		$('.page-comment-view .item').each(function() {
// 			var $this = $(this);
// 			var pictures = $this.find('.pictures').get(0);
// 			if (!pictures) {
// 				return;
// 			}
// 			var pScroll = new IScroll(pictures, {
// 				snap: true,
// 				scrollX: true,
// 				scrollY: false,
// 				mouseWheel: true
// 			});


// 			// pScroll.reset();
// 		});

// });

// ngApp.controller('PageCoupon', function($rootScope, $scope) {
	

// });


// ngApp.service('$api', function($http, $q) {

// 	var domain = 'http://192.168.0.103:7021';

// 	var headers = {};

// 	return ({
// 		favoriteExist: favoriteExist

// 	});

// 	// ---
// 	// PRIVATE METHODS.
// 	// ---
// 	function handleError( response ) {
// 		Toast('网络错误，请稍后重试！');
// 		// if (
// 		// 	! angular.isObject( response.data ) ||
// 		// 	! response.data.message
// 		// 	) {
// 		// 	return( $q.reject( "An unknown error occurred." ) );
// 		// }
// 		return( $q.reject( response ) );
// 	}

// 	function handleSuccess( response ) {
// 		return( response.data );
// 	}

// 	/**
// 	 * PUBLIC METHODS
// 	 */
// 	// 判断是否收藏
// 	function favoriteExist(id) {
// 		var request = $http({
// 			method: 'post',
// 			url: domain + '/api/favorite/exist',
// 			params: {
// 				access_token: '',
// 				goods_id: id
// 			}
// 			// data: parseData({
// 			// 	access_token: '',
// 			// 	goods_id: ''
// 			// }, data),
// 			// headers: headers
// 		});
// 		return( request.then( handleSuccess, handleError ) );
// 	}
// });

$(window).on('load', function() {
	window.MallJSBridgeEvent = document.createEvent('Event'); 
	window.MallJSBridgeEvent.initEvent('MallJSBridgeReady', false, false); 
	document.dispatchEvent(window.MallJSBridgeEvent);
});
