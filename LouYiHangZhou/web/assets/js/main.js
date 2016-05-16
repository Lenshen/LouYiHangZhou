

var log = function(msg) {
	if (typeof console != 'undefined') {
		console.log(msg);
	}
};


Vue.filter('substring', function (string, max) {
	return string.substring(0, max);
});
Vue.filter('datetime', function (string) {
	if (!string) {
		return;
	}
	return string.replace(/T/g, ' ').replace(/.\d+$/, '');
});
Vue.filter('stars', function (num) {
	if (num === undefined) {
		return;
	}
	var star = [];
	for (var i = 1, l = 5; i <= l; i ++) {
		if (i <= num) {
			star.push('<span class="icons icon-star-yellow-small"></span>');
		}
		else {
			star.push('<span class="icons icon-star-gray-small"></span>');
		}
	}
	return star.join('');
});
Vue.filter('tag', function (sku) {
	if (sku === undefined) {
		return;
	}
	sku = sku.replace(/;$/, '');
	var skus = sku.split(';');
	var tags = [];
	$.each(skus, function() {
		tags.push('<span class="tag">' + this + '</span>');
	});
	return tags.join('');
});

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


var maps = {
	goods: function(id) {
		location.href = 'goods-detail.html?id=' + id;
	}
}

// app接口
window.app = {
	hasMothed: function(name) {
		if (!window['MallJSBridge'] || !window['MallJSBridge'][name]) {
			return false;
		}
		return true;
	},
	request: function(name, params, callback) {
		if (!window['MallJSBridge']) {
			return;
		}
		MallJSBridge.request(name, params, callback);
	},
	showWaiting: function(message) {
		if (this.hasMothed('showWaiting')) {
			MallJSBridge.showWaiting(message);
		}
		else {
			this.request('showWaiting', {message: message});
		}
	},
	hideWaiting: function() {
		if (this.hasMothed('hideWaiting')) {
			MallJSBridge.hideWaiting();
		}
		else {
			this.request('hideWaiting', {});
		}
	},
	getToken: function() {
		var self = this;
		if (this.token === undefined) {
			if (this.hasMothed('getToken')) {
				this.token = MallJSBridge.getToken();
			}
			else {
				this.request('getToken', {}, function(token) {
					self.token = token;
				});
			}
		}

		return this.token;
	},
	getApplyCode: function() {
		var self = this;
		if (this.applycode === undefined) {
			if (this.hasMothed('getApplyCode')) {
				this.applycode = MallJSBridge.getApplyCode();
			}
			else {
				this.request('getApplyCode', {}, function(applycode) {
					self.applycode = applycode;
				});
			}
		}
		
		return this.applycode;
	},
	getUser: function() {
		var self = this;
		if (this.user === undefined) {
			if (this.hasMothed('getUser')) {
				this.user = MallJSBridge.getUser();
			}
			else {
				this.request('getUser', {}, function(user) {
					self.user = user;
				});
			}
		}
		
		return this.user;
	},
	signin: function() {
		if (this.hasMothed('signin')) {
			MallJSBridge.signin();
		}
		else {
			this.request('signin', {});
		}
	},
	intentaddress: function() {
		if (this.hasMothed('intentaddress')) {
			MallJSBridge.intentaddress();
		}
		else {
			this.request('intentaddress', {});
		}
	},
	intentGoodsDetail: function(id) {
		if (this.hasMothed('intentGoodsDetail')) {
			MallJSBridge.intentGoodsDetail(id);
		}
		else {
			this.request('intentGoodsDetail', {id: id});
		}
	},
	intentClassifyWeb: function(typeid, brandid) {
		if (this.hasMothed('intentClassifyWeb')) {
			MallJSBridge.intentClassifyWeb(typeid, brandid);
		}
		else {
			this.request('intentClassifyWeb', {typeid: typeid, brandid: brandid});
		}
	},
	intentOrderDetail: function(id) {
		if (this.hasMothed('intentOrderDetail')) {
			MallJSBridge.intentOrderDetail(id);
		}
		else {
			this.request('intentOrderDetail', {id: id});
		}
	},
	// 商户PID、商户私钥、商户收款账号、商品名、商品描述、商品价格，订单id
	payMoney: function(partner, rsa_private, seller, goods_name, goods_description, goods_price, order_id) {
		if (this.hasMothed('payMoney')) {
			MallJSBridge.payMoney(partner, rsa_private, seller, goods_name, goods_description, goods_price, order_id);
		}
		else {
			this.request('payMoney', {
				partner: partner,
				rsa_private: rsa_private,
				seller: seller,
				goods_name: goods_name,
				goods_description: goods_description,
				goods_price: goods_price,
				order_id: order_id
			});
		}
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
		return this.events[id];
	}
	
};


var api = {
	// domain: 'http://192.168.0.103:7021',
	domain: 'http://192.168.0.103:8078',
	ajax: function(conf) {
		return $.ajax(conf).fail(function(response) {
			// console.error(this + Mustache.render('{{url}}\nStatus: {{status}}', this, response));
		});
	},
	// 获得商品详情
	goods: function(id) {
		return this.ajax({
			type: 'GET',
			url: this.domain + '/api/goods/get',
			data: {
				access_token: app.getToken() || app.getApplyCode(),
				goods_id: id
			}
		});
	},
	// 获得商品规格
	spec: function(id) {
		return this.ajax({
			type: 'GET',
			url: this.domain + '/api/goods/spec',
			data: {
				goods_id: id
			}
		});
	},
	goodsOptional: function(id) {
		return this.ajax({
			type: 'GET',
			url: this.domain + '/api/goods/optional',
			data: {
				access_token: app.getToken(),
				goods_id: id
			}
		});
	},
	// 添加到购物车
	cartAdd: function(options) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/cart/add',
			data: $.extend({
				token: app.getToken(),
				goods_id: 0,
				qty: 1,
				sku: '',
				customized: ''
			}, options)
		});
	},
	// 更新购物车商品数量
	cartUpdate: function(options) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/cart/update',
			data: $.extend({
				token: app.getToken(),
				cart_id: 0,
				qty: 1
			}, options)
		});
	},
	// 删除购物车内的物品
	cartRemove: function(options) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/cart/remove',
			data: $.extend({
				access_token: app.getToken(),
				cart_id: 0
			}, options)
		});
	},
	// 获取购物车列表
	cartList: function() {
		return this.ajax({
			type: 'GET',
			url: this.domain + '/api/cart/getall',
			data: {
				access_token: app.getToken()
			}
		});
	},
	// 收藏商品
	favoriteAdd: function(id) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/favorite/add',
			data: {
				token: app.getToken(),
				goods_id: id
			}
		});

	},
	// 取消收藏商品
	favoriteRemove: function(id) {
		return this.ajax({
			type: 'POST',
			url: this.domain + '/api/favorite/remove',
			data: {
				access_token: app.getToken(),
				goods_id: id
			}
		});

	},
	// 检测商品是否收藏
	favoriteExist: function(id) {
		return this.ajax({
			url: this.domain + '/api/favorite/exist',
			data: {
				access_token: app.getToken(),
				goods_id: id
			}
		});
	},
	// 获取用户优惠券列表
	couponList: function(id) {
		return this.ajax({
			url: this.domain + '/api/coupon/list',
			data: {
				access_token: app.getToken()
			}
		});
	},
	// 添加优惠券
	couponAdd: function(code) {
		return this.ajax({
			url: this.domain + '/api/coupon/add',
			data: {
				access_token: app.getToken(),
				code: code,
				user_id: app.getUserID()
			}
		});
		// api/coupon/validate
		// coupon_code
		// user_ticket
		// user_id
	},
	// 验证优惠券号码
	couponValidate: function(code) {
		return this.ajax({
			url: this.domain + '/api/coupon/validate',
			data: {
				coupon_code: code,
				user_ticket: '',
				user_id: ''
			}
		});
		// api/coupon/validate
		// coupon_code
		// user_ticket
		// user_id
	},
	// 获取订单支付方式
	payment: function() {
		return this.ajax({
			url: this.domain + '/api/config/payment',
			data: {
				access_token: app.getToken()
			}
		});
	},
	// 获取订单配送方式
	shipping: function() {
		return this.ajax({
			url: this.domain + '/api/config/shipping',
			data: {
				access_token: app.getToken()
			}
		});
	},
	// 获取一条用户地址
	getAddress: function() {
		return this.ajax({
			url: this.domain + '/api/address/get',
			data: {
				access_token: app.getToken()
			}
		});
	},
	// 计算运费
	shippingFee: function(id, region) {
		return this.ajax({
			url: this.domain + '/api/config/shippingfee',
			data: {
				access_token: app.getToken(),
				regionname: region,
				shipping_id: id
			}
		});
	},
	// 获得购物车已选商品信息
	cartSelected: function(id) {
		return this.ajax({
			url: this.domain + '/api/cart/getselected',
			data: {
				access_token: app.getToken(),
				goods_id: id
			}
		});
	},
	// 提交订单
	orderSubmit: function(data) {
		return this.ajax({
			url: this.domain + '/api/order/add',
			type: 'POST',
			data: $.extend({
				access_token: app.getToken(),
				country: '',   // 国家
				province: '',   // 省份
				city: '',   // 城市
				area: '',   // 城市
				address: '',   // 街道地址
				zip: '',   // 邮编
				email: '',   // 电子邮箱
				phone: '',   // 电话号码
				mobile: '',   // 手机号码
				remark: '',   // 补充说明
				coupon_code: '',   // 优惠券号码
				payment_id: '',   // 支付方式
				shipping_id: ''   // 运输方式
			}, data)
		});
		
	},
	// 订单列表
	orders: function(status) {
		return this.ajax({
			url: this.domain + '/api/order/mylist',
			type: 'GET',
			data: {
				access_token: app.getToken(),
				status: status   // 运输方式
			}
		});
		
	},
	// 订单详情
	orderDetail: function(id) {
		return this.ajax({
			url: this.domain + '/api/order/get',
			type: 'GET',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
		
	},
	// 调用位链接数据
	spaceLink: function(code) {
		return this.ajax({
			url: this.domain + '/api/space/link',
			type: 'GET',
			data: {
				access_token: app.getToken() || app.getApplyCode(),
				code: code
			}
		});
		
	},
	// 调用位商品数据
	spaceGoods: function(code) {
		return this.ajax({
			url: this.domain + '/api/space/goods',
			type: 'GET',
			data: {
				access_token: app.getToken() || app.getApplyCode(),
				code: code
			}
		});
		
	},
	// 商品分类列表页，获取子分类
	brandlist: function(id) {
		return this.ajax({
			url: this.domain + '/api/goods/brandlist',
			type: 'GET',
			data: {
				access_token: app.getToken() || app.getApplyCode(),
				goodstype_id: id
			}
		});
		
	},
	// 通过分类id获取商品列表
	// getGoodslist: function(id) {
	// 	return this.ajax({
	// 		url: this.domain + '/api/goods/filter',
	// 		type: 'GET',
	// 		data: {
	// 			access_token: app.getToken(),
	// 			goodstype_id: id
	// 		}
	// 	});
	// },
	search: function(options) {
		return this.ajax({
			url: this.domain + '/api/goods/search',
			type: 'POST',
			cache: false,
			data: $.extend({
				access_token: app.getToken() || app.getApplyCode(),
				keyword: '',
				goods_type_id: '',
				brand_id: '',
				sort_index: '', // 售价 1、2，销量 6、7
				page_index: 1,
				page_size: 20
			}, options)
		});
	},
	// 获取商品品论列表
	goodsComments: function(options) {
		return this.ajax({
			url: this.domain + '/api/user/commentlist',
			type: 'POST',
			data: $.extend({
				access_token: app.getToken(),
				goods_id: '',
				page_index: '',
				page_size: ''
			}, options)
		});
	},
	// 获得订单中的待评价商品信息
	getByOrder: function(id) {
		return this.ajax({
			url: this.domain + '/api/user/getbyorder',
			type: 'POST',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
		
	},
	// 新建一个评论
	addComment: function(options) {
		return this.ajax({
			url: this.domain + '/api/user/addcomment',
			type: 'POST',
			data: $.extend({
				access_token: app.getToken(),
				order_id: 0,
				sku_name: '',
				goods_id: 0,
				content: '',
				star: 0
			}, options)
		});
		
	},
	// 提交评论
	submitComment: function(options) {
		return this.ajax({
			url: this.domain + '/api/user/updatecomment',
			type: 'POST',
			data: $.extend({
				access_token: app.getToken(),
				comment_id: 0,
				star: 0,
				content: ''
			}, options)
		});
	},
	orderReceived: function(id) {
		return this.ajax({
			url: this.domain + '/api/order/received',
			type: 'POST',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
	},
	orderCancel: function(id) {
		return this.ajax({
			url: this.domain + '/api/order/cancel',
			type: 'POST',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
	},
	orderDel: function(id) {
		return this.ajax({
			url: this.domain + '/api/order/cancel',
			type: 'GET',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
	},
	orderPay: function(id) {
		return this.ajax({
			url: this.domain + '/api/order/pay',
			type: 'GET',
			data: {
				access_token: app.getToken(),
				order_id: id
			}
		});
	},
	getPayConfig: function(id) {
		return this.ajax({
			url: this.domain + '/api/config/getalipay',
			type: 'GET',
			data: {
				access_token: app.getApplyCode()
			}
		});
	},
	getQueryExpress: function(code, name) {
		return this.ajax({
			url: this.domain + '/api/order/queryexpress',
			type: 'GET',
			data: {
				access_token: app.getApplyCode(),
				post_code: code,
				company: name
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
function initBridge() {

    window.MallJSBridgeEvent = document.createEvent('Event'); 
    window.MallJSBridgeEvent.initEvent('MallJSBridgeReady', false, false); 
    document.dispatchEvent(window.MallJSBridgeEvent);
}

$(window).on('load', function() {
	if (navigator.userAgent.toLowerCase().indexOf('pc') >= 0) {
		MallJSBridge = {
			getToken: function() {
				return '687C090431AF1ABBC85AD593943388B0762BAB34586F1A7D8BE07449CBA94B362F0CEACC1E29D715F7C3BAB3D9A646ED';
			},
			getApplyCode: function() {
				return 100;
			},
			intentClassifyWeb: function() {
				
			}
		};
		window.MallJSBridgeEvent = document.createEvent('Event'); 
		window.MallJSBridgeEvent.initEvent('MallJSBridgeReady', false, false); 
		document.dispatchEvent(window.MallJSBridgeEvent);
	}
});
