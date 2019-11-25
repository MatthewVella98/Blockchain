"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var tslib_1 = require("tslib");
var yup = require("yup");
var convector_core_model_1 = require("@worldsibu/convector-core-model");
var Aggreement = (function (_super) {
    tslib_1.__extends(Aggreement, _super);
    function Aggreement() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.type = 'io.worldsibu.aggreement';
        return _this;
    }
    tslib_1.__decorate([
        convector_core_model_1.ReadOnly(),
        convector_core_model_1.Required()
    ], Aggreement.prototype, "type", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.string())
    ], Aggreement.prototype, "name", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required,
        convector_core_model_1.ReadOnly
    ], Aggreement.prototype, "title", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required,
        convector_core_model_1.ReadOnly
    ], Aggreement.prototype, "description", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required,
        convector_core_model_1.ReadOnly
    ], Aggreement.prototype, "party1", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required,
        convector_core_model_1.ReadOnly
    ], Aggreement.prototype, "party2", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required
    ], Aggreement.prototype, "finishDate", void 0);
    tslib_1.__decorate([
        convector_core_model_1.ReadOnly(),
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.number())
    ], Aggreement.prototype, "created", void 0);
    tslib_1.__decorate([
        convector_core_model_1.Required(),
        convector_core_model_1.Validate(yup.number())
    ], Aggreement.prototype, "modified", void 0);
    return Aggreement;
}(convector_core_model_1.ConvectorModel));
exports.Aggreement = Aggreement;
//# sourceMappingURL=aggreement.model.js.map