(function () {
  "use strict";
  var t = {
      3032: function (t, e, n) {
        var i = n(8935),
          o = n(6166),
          s = n.n(o);
        let a = {
          baseURL: "https://vrp_radio/"
        };
        const r = s().create(a);
        r.interceptors.request.use((function (t) {
          return t
        }), (function (t) {
          return Promise.reject(t)
        })), r.interceptors.response.use((function (t) {
          return t
        }), (function (t) {
          return Promise.reject(t)
        })), Plugin.install = function (t, e) {
          t.axios = r, window.axios = r, Object.defineProperties(t.prototype, {
            axios: {
              get() {
                return r
              }
            },
            $axios: {
              get() {
                return r
              }
            }
          })
        }, i.Z.use(Plugin);
        Plugin;
        var u = function () {
            var t = this,
              e = t.$createElement,
              i = t._self._c || e;
            return i("div", {
              attrs: {
                id: "app"
              }
            }, [i("img", {
              attrs: {
                src: n(6111)
              }
            }), i("div", {
              staticClass: "radio-display"
            }, [i("div", {
              staticClass: "top-container"
            }, [i("i", {
              staticClass: "fa-solid font-size-small",
              class: t.volumeIcons[t.volume]
            }), i("span", {
              staticClass: "notification-text"
            }, [t._v(t._s(t.message))]), i("i", {
              staticClass: "fa-solid font-size-small-2",
              class: t.batteryIcons[t.battery]
            })]), i("div", {
              staticClass: "text-container"
            }, [i("span", {
              staticClass: "placeholder"
            }, [t._v("0000")]), i("span", {
              staticClass: "real-text"
            }, [t._v(t._s(t.frequency))])])]), i("div", {
              staticClass: "control-container"
            }, [i("div", {
              staticClass: "center-panel control-panel-container"
            }, [i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.aumentarVolume.apply(null, arguments)
                }
              }
            }), i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.diminuirVolume.apply(null, arguments)
                }
              }
            })]), i("div", {
              staticClass: "left-panel side-panel control-panel-container"
            }, [i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.ativarDesativarSom.apply(null, arguments)
                }
              }
            }), i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.desconectar.apply(null, arguments)
                }
              }
            })]), i("div", {
              staticClass: "right-panel side-panel control-panel-container"
            }, [i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.escolherFrequencia.apply(null, arguments)
                }
              }
            }), i("button", {
              staticClass: "button-painel",
              on: {
                click: function (e) {
                  return e.stopPropagation(), t.selecionarFrequencia.apply(null, arguments)
                }
              }
            })])])])
          },
          c = [],
          l = n(2932),
          p = {
            name: "App",
            data: () => ({
              message: "Desconectado",
              activeFrequency: !1,
              frequency: 0,
              battery: 0,
              volume: 2,
              lastVolume: -1,
              is_muted: !1,
              tw: null,
              batteryIcons: ["fa-battery-empty", "fa-battery-quarter", "fa-battery-half", "fa-battery-full"],
              volumeIcons: ["fa-volume-xmark", "fa-volume-off", "fa-volume-low", "fa-volume-high"]
            }),
            methods: {
              sendRequest(t) {
                this.$axios.post("pma-radio", t).catch((() => {
                  this.frequency = "Erro"
                }))
              },
              selecionarFrequencia: function () {
                this.sendRequest({
                  action: "SET_FREQUENCY",
                  payload: this.frequency
                })
              },
              ativarDesativarSom: function () {
                this.is_muted = !this.is_muted, this.is_muted ? (this.lastVolume = this.volume, this.volume = 0) : this.volume = this.lastVolume, this.sendRequest({
                  action: "MUTE_VOLUME",
                  payload: this.is_muted
                })
              },
              desconectar: function () {
                this.frequency = 0, this.sendRequest({
                  action: "DISCONNECT"
                })
              },
              escolherFrequencia: function () {
                this.activeFrequency = !this.activeFrequency
              },
              aumentarVolume: function () {
                this.activeFrequency ? this.frequency < 9999 && this.frequency++ : this.volume < this.volumeIcons.length - 1 && (this.volume++, this.sendRequest({
                  action: "CHANGE_VOLUME",
                  payload: this.volume
                }))
              },
              diminuirVolume: function () {
                this.activeFrequency ? this.frequency > 0 && this.frequency-- : this.volume > 0 && (this.volume--, this.sendRequest({
                  action: "CHANGE_VOLUME",
                  payload: this.volume
                }))
              },
              animarBateria: function () {
                setInterval((() => {
                  this.battery >= 3 && (this.battery = -1), this.battery++
                }), 1e3)
              },
              onMessage(t) {
                const {
                  data: e
                } = t;
                e.action && "show" == e.action && (!this.tw || this.tw && !this.tw.isActive()) && (this.tw = l.ZP.to("#app", {
                  duration: 1,
                  bottom: -160
                }).eventCallback("onReverseComplete", null))
              },
              onkeydown(t) {
                const {
                  key: e
                } = t;
                "escape" == e.toLowerCase() && (this.tw.isActive() || (this.tw.eventCallback("onReverseComplete", (() => {
                  this.sendRequest({
                    action: "CLOSE_NUI"
                  })
                })), this.tw.reverse()))
              }
            },
            async mounted() {
              await this.$nextTick(), window.addEventListener("message", this.onMessage), window.addEventListener("keydown", this.onkeydown), this.animarBateria()
            },
            beforeDestroy() {
              window.removeEventListener("message", this.onMessage), window.removeEventListener("keydown", this.onkeydown)
            }
          },
          f = p,
          h = n(1001),
          d = (0, h.Z)(f, u, c, !1, null, null, null),
          v = d.exports;
        i.Z.config.productionTip = !1, new i.Z({
          render: t => t(v)
        }).$mount("#app")
      },
      6111: function (t, e, n) {
        t.exports = n.p + "img/radio.774efca6.png"
      }
    },
    e = {};

  function n(i) {
    var o = e[i];
    if (void 0 !== o) return o.exports;
    var s = e[i] = {
      exports: {}
    };
    return t[i](s, s.exports, n), s.exports
  }
  n.m = t,
    function () {
      var t = [];
      n.O = function (e, i, o, s) {
        if (!i) {
          var a = 1 / 0;
          for (l = 0; l < t.length; l++) {
            i = t[l][0], o = t[l][1], s = t[l][2];
            for (var r = !0, u = 0; u < i.length; u++)(!1 & s || a >= s) && Object.keys(n.O).every((function (t) {
              return n.O[t](i[u])
            })) ? i.splice(u--, 1) : (r = !1, s < a && (a = s));
            if (r) {
              t.splice(l--, 1);
              var c = o();
              void 0 !== c && (e = c)
            }
          }
          return e
        }
        s = s || 0;
        for (var l = t.length; l > 0 && t[l - 1][2] > s; l--) t[l] = t[l - 1];
        t[l] = [i, o, s]
      }
    }(),
    function () {
      n.n = function (t) {
        var e = t && t.__esModule ? function () {
          return t["default"]
        } : function () {
          return t
        };
        return n.d(e, {
          a: e
        }), e
      }
    }(),
    function () {
      n.d = function (t, e) {
        for (var i in e) n.o(e, i) && !n.o(t, i) && Object.defineProperty(t, i, {
          enumerable: !0,
          get: e[i]
        })
      }
    }(),
    function () {
      n.g = function () {
        if ("object" === typeof globalThis) return globalThis;
        try {
          return this || new Function("return this")()
        } catch (t) {
          if ("object" === typeof window) return window
        }
      }()
    }(),
    function () {
      n.o = function (t, e) {
        return Object.prototype.hasOwnProperty.call(t, e)
      }
    }(),
    function () {
      n.p = ""
    }(),
    function () {
      var t = {
        143: 0
      };
      n.O.j = function (e) {
        return 0 === t[e]
      };
      var e = function (e, i) {
          var o, s, a = i[0],
            r = i[1],
            u = i[2],
            c = 0;
          if (a.some((function (e) {
              return 0 !== t[e]
            }))) {
            for (o in r) n.o(r, o) && (n.m[o] = r[o]);
            if (u) var l = u(n)
          }
          for (e && e(i); c < a.length; c++) s = a[c], n.o(t, s) && t[s] && t[s][0](), t[s] = 0;
          return n.O(l)
        },
        i = self["webpackChunkpma_radio"] = self["webpackChunkpma_radio"] || [];
      i.forEach(e.bind(null, 0)), i.push = e.bind(null, i.push.bind(i))
    }();
  var i = n.O(void 0, [998], (function () {
    return n(3032)
  }));
  i = n.O(i)
})();