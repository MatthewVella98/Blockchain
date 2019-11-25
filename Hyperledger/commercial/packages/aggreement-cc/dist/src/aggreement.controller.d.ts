import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import { ConvectorController } from '@worldsibu/convector-core';
import { Aggreement } from './aggreement.model';
export declare class AggreementController extends ConvectorController<ChaincodeTx> {
    create(aggreement: Aggreement): Promise<void>;
}
