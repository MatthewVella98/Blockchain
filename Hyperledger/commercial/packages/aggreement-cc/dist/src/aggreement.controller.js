"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var tslib_1 = require("tslib");
var convector_core_1 = require("@worldsibu/convector-core");
var aggreement_model_1 = require("./aggreement.model");
var AggreementController = (function (_super) {
    tslib_1.__extends(AggreementController, _super);
    function AggreementController() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    AggreementController.prototype.create = function (aggreement) {
        return tslib_1.__awaiter(this, void 0, void 0, function () {
            return tslib_1.__generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4, aggreement.save()];
                    case 1:
                        _a.sent();
                        return [2];
                }
            });
        });
    };
    tslib_1.__decorate([
        convector_core_1.Invokable(),
        tslib_1.__param(0, convector_core_1.Param(aggreement_model_1.Aggreement))
    ], AggreementController.prototype, "create", null);
    AggreementController = tslib_1.__decorate([
        convector_core_1.Controller('aggreement')
    ], AggreementController);
    return AggreementController;
}(convector_core_1.ConvectorController));
exports.AggreementController = AggreementController;
//# sourceMappingURL=aggreement.controller.js.map