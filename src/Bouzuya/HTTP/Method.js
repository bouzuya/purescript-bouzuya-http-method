"use strict";

exports.indexOf = function (s) {
  return function (v) {
    return s.indexOf(v);
  };
};

exports.length = function (s) {
  return s.length;
};

exports.toCharArray = function (s) {
  return s.split('');
};

exports.toUpperCase = function (s) {
  return s.toUpperCase();
};
