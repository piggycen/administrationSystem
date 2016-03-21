var breaker, divnode, formatPrice, getElementOffset, hasClass, lastModified, rquickExpr, trim;

formatPrice = function(price) {
  var i, j, len, p, prices;
  if (!price) {
    return null;
  }
  if (price.indexOf("-") !== -1) {
    prices = price.split("-");
    for (i = j = 0, len = prices.length; j < len; i = ++j) {
      p = prices[i];
      prices[i] = parseFloat(p).toFixed(2);
    }
    return prices.join(" - ");
  } else {
    return parseFloat(price).toFixed(2);
  }
};

window.$id = function(id) {
  return document.getElementById(id);
};

window.$Show = function(id) {
  return $id(id).style.display = "block";
};

window.$Hide = function(id) {
  return $id(id).style.display = "none";
};

rquickExpr = /^#([a-zA-Z0-9-]+)|(\w+)|\.([a-zA-Z0-9-]+)$/;

trim = function(input) {
  if (input.replace) {
    return input.replace(/(^\s*)|(\s*$)/g, "");
  }
  return input;
};

if (!String.prototype.trim) {
  String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
  };
}

hasClass = function(obj, cls) {
  if (obj.className && obj.className.match(new RegExp('(\\b|^)' + cls + '(\\b|$)'))) {
    return true;
  } else {
    return false;
  }
};

window.addClass = function(obj, cls) {
  if ((obj != null) && !hasClass(obj, cls)) {
    return obj.className = trim(trim(obj.className) + " " + cls);
  }
};

window.removeClass = function(obj, cls) {
  var reg;
  if ((obj != null) && hasClass(obj, cls)) {
    reg = new RegExp('(\\b|^)' + cls + '(\\b|$)');
    return obj.className = trim(obj.className.replace(reg, ' '));
  }
};

getElementOffset = function(elem) {
  var i, iterate_count, j, newposx, newposy, posx, posy;
  posx = 0;
  posy = 0;
  iterate_count = 0;
  for (i = j = 0; j < 1000; i = j += 1) {
    if (!elem || (elem.nodeName.toLowerCase() === "body")) {
      break;
    }
    newposx = parseInt(elem.offsetLeft || 0) + posx;
    newposy = parseInt(elem.offsetTop || 0) + posy;
    posx = newposx;
    posy = newposy;
    elem = elem.offsetParent;
    if (elem && (elem.nodeName.toLowerCase() !== "body")) {
      posx -= elem.scrollLeft || 0;
      posy -= elem.scrollTop || 0;
    }
  }
  return {
    x: posx,
    y: posy
  };
};

window.getElementsByClassName = function(classname, node) {
  var a, els, j, len, nodeitem, re;
  if (node == null) {
    node = document;
  }
  a = [];
  re = new RegExp('(^| )' + classname + '( |$)');
  els = node.getElementsByTagName("*");
  for (j = 0, len = els.length; j < len; j++) {
    nodeitem = els[j];
    if (re.test(nodeitem.className)) {
      a.push(nodeitem);
    }
  }
  return a;
};

divnode = document.createElement('div');

if (!divnode.getElementsByClassName) {
  divnode.constructor.prototype.getElementsByClassName = function(className) {
    return getElementsByClassName(className, this);
  };
}

window.$ = window.jQuery = function(selector, context) {
  return new jQuery.fn.init(selector, context);
};

breaker = {};

jQuery.isArray = function(obj) {
  return obj.constructor === Array;
};

jQuery.isFunction = function(obj) {
  return typeof obj === "function";
};

jQuery.isString = function(obj) {
  return typeof obj === "string";
};

jQuery.each = function(obj, iterator) {
  var index, item, j, key, len, results, v;
  if (obj === null) {
    return;
  }
  if (obj.length === +obj.length && obj.length > 0) {
    results = [];
    for (index = j = 0, len = obj.length; j < len; index = ++j) {
      item = obj[index];
      results.push(iterator(item, index, obj));
    }
    return results;
  } else if (!obj.splice) {
    for (key in obj) {
      v = obj[key];
      if (iterator(key, v, obj) === breaker) {
        return;
      }
    }
  }
};

lastModified = {};

jQuery.getCookie = function(name) {
  var arr;
  arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
  if (arr !== null) {
    return unescape(arr[2]);
  }
  return null;
};

jQuery.setCookie = function(name, value, time) {
  var date, str;
  str = name + "=" + escape(value) + ";path=/";
  if (time > 0) {
    date = new Date();
    date.setTime(date.getTime() + time);
    str += ";expires=" + date.toGMTString();
  }
  return document.cookie = str;
};

jQuery.delCookie = function(name) {
  var cval, exp;
  exp = new Date();
  exp.setTime(exp.getTime() - 1);
  cval = getCookie(name);
  if (cval !== null) {
    return document.cookie = name + "=" + cval + ";path=/;expires=" + exp.toGMTString();
  }
};

jQuery.getParam = function(name, url) {
  var r, reg, search;
  if (url == null) {
    url = window.location.href;
  }
  search = url.split("#")[0].split("?")[1] || "";
  reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
  r = search.substr(0).match(reg);
  if (r) {
    return unescape(r[2]);
  }
  return null;
};

jQuery.addParam = function(url, key, value) {
  var originalValue;
  originalValue = jQuery.getParam(key, url);
  if (!originalValue) {
    url += url.indexOf("?") > -1 ? "&" : "?";
    url += key + "=" + (encodeURIComponent(value));
    return url;
  } else {
    return jQuery.replaceParam(url, key, value);
  }
};

jQuery.replaceParam = function(url, key, newValue) {
  var originalValue;
  originalValue = jQuery.getParam(key, url);
  if (originalValue) {
    return url.replace(key + "=" + (encodeURIComponent(originalValue)), key + "=" + (encodeURIComponent(newValue)));
  } else {
    return url;
  }
};

jQuery.ajax = function(s) {
  var ajaxSettings, complete, data, dataArray, e, field, formEl, ival, j, key, len, onreadystatechange, paramList, ref, ref1, requestDone, success, ts, value, xml;
  ajaxSettings = {
    global: true,
    type: "GET",
    cache: true,
    timeout: 0,
    contentType: "application/x-www-form-urlencoded",
    async: true,
    data: null,
    timeout: 30000,
    dataType: "text",
    accepts: {
      xml: "application/xml, text/xml",
      html: "text/html",
      script: "text/javascript, application/javascript",
      json: "application/json, text/javascript",
      text: "text/plain",
      _default: "*/*"
    }
  };
  for (key in ajaxSettings) {
    if (typeof s[key] === "undefined") {
      s[key] = ajaxSettings[key];
    }
  }
  data = null;
  if (s.data) {
    if (jQuery.isString(s.data)) {
      formEl = document.getElementById(s.data);
      if (formEl && formEl.nodeName === "FORM") {
        paramList = formEl.getElementsByTagName("input");
        dataArray = [];
        for (j = 0, len = paramList.length; j < len; j++) {
          field = paramList[j];
          dataArray.push(field.name + "=" + (encodeURIComponent(field.value)));
          s.data = dataArray.join("&");
        }
      }
    } else {
      dataArray = [];
      ref = s.data;
      for (key in ref) {
        value = ref[key];
        dataArray.push(key + "=" + (encodeURIComponent(value)));
      }
      s.data = dataArray.join("&");
    }
  }
  if (s.cache === false && s.type.toLowerCase() === "get") {
    ts = (new Date()).getTime();
    s.url += (s.url.match(/\?/) ? "&" : "?");
    s.url = s.url + "j_cache_ts=" + ts;
  }
  if (s.data && s.type.toLowerCase() === "get") {
    s.url += s.url.match(/\?/) ? "&" : "?";
    s.url += s.data;
    s.data = null;
  }
  requestDone = false;
  if (window.XMLHttpRequest) {
    xml = new XMLHttpRequest();
  } else {
    xml = new ActiveXObject("Microsoft.XMLHTTP");
  }
  xml.open(s.type, s.url, s.async);
  xml.timeout = s.timeout;
  try {
    if (s.data) {
      xml.setRequestHeader("Content-Type", s.contentType);
    }
    xml.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    xml.setRequestHeader("Accept", (ref1 = s.dataType && s.accepts[s.dataType]) != null ? ref1 : s.accepts[s.dataType] + {
      ", */*": s.accepts._default
    });
  } catch (_error) {
    e = _error;
  }
  success = function(data, status) {
    if (s.success) {
      return s.success(data, status);
    }
  };
  complete = function(xml, status) {
    if (s.complete) {
      return s.complete(xml, status);
    }
  };
  onreadystatechange = function(isTimeout) {
    var ival, modRes, status;
    if (!requestDone && xml && (xml.readyState === 4 || isTimeout === "timeout")) {
      requestDone = true;
      if (ival) {
        clearInterval(ival);
        ival = null;
      }
      status = isTimeout === "timeout" && "timeout" || !jQuery.httpSuccess(xml) && "error" || "success";
      if (status === "success") {
        try {
          data = jQuery.httpData(xml, s.dataType);
        } catch (_error) {
          e = _error;
          status = "parsererror";
        }
      }
      if (status === "success") {
        modRes;
        try {
          modRes = xml.getResponseHeader("Last-Modified");
        } catch (_error) {
          e = _error;
        }
        success(data, status);
      } else {
        jQuery.handleError(s, xml, status);
      }
      complete(xml, status);
      if (s.async) {
        return xml = null;
      }
    }
  };
  if (s.async) {
    ival = setInterval(onreadystatechange, 13);
  }
  try {
    if (s.type.toLowerCase() === "post") {
      xml.send(s.data);
    } else {
      xml.send();
    }
  } catch (_error) {
    e = _error;
    jQuery.handleError(s, xml, null, e);
  }
  if (!s.async) {
    onreadystatechange();
  }
  return xml;
};

jQuery.handleError = function(s, xml, status, e) {
  if (s.error) {
    return s.error(xml, status, e);
  }
};

jQuery.httpSuccess = function(r) {
  var e;
  try {
    return !r.status && location.protocol === "file:" || (r.status >= 200 && r.status < 300) || r.status === 304 || r.status === 1223 || jQuery.browser.safari && r.status === void 0;
  } catch (_error) {
    e = _error;
  }
  return false;
};

jQuery.httpData = function(r, type) {
  var ct, data;
  ct = r.getResponseHeader("content-type");
  data = r.responseText;
  if (type === "json") {
    data = eval("(" + data + ")");
  }
  return data;
};

jQuery.get = function(url, data, callback, type) {
  if ($.isFunction(data)) {
    type = callback;
    callback = data;
    data = void 0;
  }
  if (!$.isFunction(callback)) {
    type = callback;
    callback = void 0;
  }
  return $.ajax({
    type: "GET",
    url: url,
    data: data,
    success: callback,
    dataType: type
  });
};

jQuery.post = function(url, data, callback, type) {
  if ($.isFunction(data)) {
    type = callback;
    callback = data;
    data = void 0;
  }
  if (!$.isFunction(callback)) {
    type = callback;
    callback = void 0;
  }
  return $.ajax({
    type: "POST",
    url: url,
    data: data,
    success: callback,
    dataType: type
  });
};

jQuery.fn = jQuery.prototype = {
  init: function(selector, root) {
    var dotIndex, firstIndex, idmatch, index, item, j, k, l, len, len1, len2, m, match, node, rst, sharpIndex, subSelector, tagName, tmpRst;
    if (root == null) {
      root = document;
    }
    if (!selector) {
      this.length = 0;
      return this;
    }
    rst = [];
    if (root !== document) {
      root = $(root)[0];
    }
    if (typeof selector === "string") {
      this.selector = selector;
      match = rquickExpr.exec(selector);
      for (index = j = 0, len = match.length; j < len; index = ++j) {
        item = match[index];
        if (item === '') {
          match[index] = void 0;
        }
      }
      if ((m = match[1])) {
        idmatch = document.getElementById(m);
        if (idmatch) {
          rst.push(idmatch);
        } else {
          idmatch = document.getElementById(m);
          if (idmatch) {
            rst.push(idmatch);
          }
        }
      } else if ((m = match[2])) {
        sharpIndex = selector.indexOf("#");
        dotIndex = selector.indexOf(".");
        firstIndex = 0;
        tagName = m;
        tmpRst = [];
        if (sharpIndex > -1 || dotIndex > -1) {
          if (sharpIndex * dotIndex < 0) {
            firstIndex = sharpIndex > 0 ? sharpIndex : dotIndex;
          } else {
            firstIndex = sharpIndex > dotIndex ? dotIndex : sharpIndex;
          }
          subSelector = selector.substring(firstIndex + 1, selector.length);
          tmpRst = root.getElementsByTagName(m);
          for (k = 0, len1 = tmpRst.length; k < len1; k++) {
            node = tmpRst[k];
            if (hasClass(node, subSelector)) {
              rst.push(node);
            }
          }
        } else {
          rst = root.getElementsByTagName(m);
        }
      } else if ((m = match[3])) {
        rst = root.getElementsByClassName(m);
      }
    } else if (selector.length) {
      return selector;
    } else if (selector.nodeType) {
      rst.push(selector);
    }
    for (index = l = 0, len2 = rst.length; l < len2; index = ++l) {
      node = rst[index];
      this[index] = node;
    }
    this.length = rst.length;
    if (selector.selector) {
      this.selector = selector.selector;
    }
    return this;
  },
  addClass: function(className) {
    return this.each(function(item, index, list) {
      return addClass(item, className);
    });
  },
  removeClass: function(className) {
    return this.each(function(item, index, list) {
      return removeClass(item, className);
    });
  },
  style: function(styleName, value) {
    var j, k, len, len1, node;
    if (value !== void 0) {
      for (j = 0, len = this.length; j < len; j++) {
        node = this[j];
        node.style[styleName] = value;
      }
    } else {
      if ($.isString(styleName)) {
        return this[0] && this[0].style[styleName];
      } else {
        for (k = 0, len1 = this.length; k < len1; k++) {
          node = this[k];
          $.each(styleName, function(key, value, list) {
            return node.style[key] = value;
          });
        }
      }
    }
    return this;
  },
  hide: function() {
    this.style('display', 'none');
    return this;
  },
  show: function() {
    return this.style('display', 'block');
  },
  hasClass: function(className) {
    return hasClass(this[0], className);
  },
  each: function(iterator) {
    $.each(this, iterator);
    return this;
  },
  attr: function(name, value) {
    var j, len, node, rst;
    rst = null;
    if (arguments.length === 2) {
      for (j = 0, len = this.length; j < len; j++) {
        node = this[j];
        if (node.setAttribute) {
          node.setAttribute(name, value);
        } else {
          node[name] = value;
        }
      }
      return this;
    } else if (this[0].getAttribute) {
      rst = this[0].getAttribute(name);
    }
    if (!rst) {
      return this[0][name];
    }
    return rst;
  }
};

jQuery.fn.init.prototype = jQuery.fn;