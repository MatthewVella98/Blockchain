"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var tslib_1 = require("tslib");
var yup = require("yup");
var convector_core_model_1 = require("@worldsibu/convector-core-model");
var Kickstarter = (function (_super) {
    tslib_1.__extends(Kickstarter, _super);
    function Kickstarter() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.type = 'io.worldsibu.kickstarter';
        return _this;
    }
    tslib_1.__decorate([
        convector_core_model_1.ReadOnly(),
        convector_core_model_1.Required()
    ], Kickstarter.prototype, "type", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.string())
    ], Kickstarter.prototype, "name", void 0);
    tslib_1.__decorate([
        convector_core_model_1.ReadOnly(),
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.number())
    ], Kickstarter.prototype, "created", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.number())
    ], Kickstarter.prototype, "modified", void 0);
    return Kickstarter;
}(convector_core_model_1.ConvectorModel));
exports.Kickstarter = Kickstarter;
//# sourceMappingURL=kickstarter.model.js.map