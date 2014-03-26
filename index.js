function __unite(ints) {
    var result = [];

    for (var idx1 = 0; idx1 < ints.length; ++idx1) {
        if (result.indexOf(idx1) === -1) {
            var x = ints[idx1];

            for (var idx2 = idx1 + 1; idx2 < ints.length; ++idx2) {
                if (result.indexOf(idx2) === -1) {
                    var y = ints[idx2];

                    if (x.isIntersect(y) || x.isCloseTo(y)) {
                        x.unite(y);
                        result.push(idx2);
                    }
                }
            }
        }
    }
    return result;
}

var HOInterval = (function () {
    function HOInterval(x, b) {
        if (typeof b === "undefined") { b = x; }
        if (x instanceof HOInterval) {
            this.a = x.a;
            this.b = x.b;
        } else {
            this.a = x;
            this.b = b;
        }
    }
    HOInterval.length = function (int) {
        return int.b - int.a;
    };

    HOInterval.isValid = function (a, b) {
        if (typeof b === "undefined") { b = a; }
        if (a instanceof HOInterval) {
            a = a.a;
            b = a.b;
        }
        return a <= b;
    };

    HOInterval.unite = function () {
        var input = [];
        for (var _i = 0; _i < (arguments.length - 0); _i++) {
            input[_i] = arguments[_i + 0];
        }
        var ints;

        if (input.length === 1) {
            ints = input[0];
        } else {
            ints = input;
        }

        var united;

        while ((united = __unite(ints)) && united.length) {
            united.sort().reverse();

            for (var idx in united) {
                ints.splice(united[idx], 1);
            }
        }

        return ints;
    };

    HOInterval.gaps = function () {
        var input = [];
        for (var _i = 0; _i < (arguments.length - 0); _i++) {
            input[_i] = arguments[_i + 0];
        }
        var ints;

        if (input.length === 1) {
            ints = input[0];
        } else {
            ints = input;
        }

        if (ints.length < 2) {
            return [];
        }

        var result = [];

        for (var idx = 0; idx < ints.length - 1; ++idx) {
            var aInt = ints[idx];
            var bInt = ints[idx + 1];

            if (aInt.isIntersect(bInt) || aInt.isCloseTo(bInt)) {
                continue;
            }

            var maxA = (aInt.a > bInt.a) ? aInt.a : bInt.a;
            var minB = (aInt.b < bInt.b) ? aInt.b : bInt.b;
            result.push(new HOInterval(minB, maxA));
        }

        return result;
    };

    HOInterval.intersect = function (a, b) {
        return (new HOInterval(a)).intersect(b);
    };

    HOInterval.prototype.isCloseTo = function (other) {
        return (this.b == other.a) || (this.a == other.b);
    };

    HOInterval.prototype.isEqualsTo = function (other) {
        return (this.a == other.a) && (this.b == other.b);
    };

    HOInterval.prototype.isIntersect = function (x, y) {
        if (typeof y === "undefined") { y = x; }
        if (x instanceof HOInterval) {
            y = x.b;
            x = x.a;
        }

        var a = this.a;
        var b = this.b;

        if ((a < b) && (x < y)) {
            return ((a <= x) && (x < b)) || ((x < a) && (a < y));
        } else if ((a < b) && (x == y)) {
            return (a <= x) && (x < b);
        } else if ((a == b) && (x < b)) {
            return (x <= a) && (a < b);
        } else if ((a == b) && (x == y)) {
            return a == x;
        }
    };

    HOInterval.prototype.unite = function (other) {
        if (this.isIntersect(other) || this.isCloseTo(other)) {
            var minA = (this.a < other.a) ? this.a : other.a;
            var maxB = (this.b > other.b) ? this.b : other.b;

            this.a = minA;
            this.b = maxB;
        }
        return this;
    };

    HOInterval.prototype.intersect = function (other) {
        if (this.isIntersect(other)) {
            var maxA = (this.a > other.a) ? this.a : other.a;
            var minB = (this.b < other.b) ? this.b : other.b;

            this.a = maxA;
            this.b = minB;
        }
        return this;
    };

    HOInterval.prototype.add = function (val) {
        this.a += val;
        this.b += val;
        return this;
    };
    return HOInterval;
})();

module.exports = HOInterval;
