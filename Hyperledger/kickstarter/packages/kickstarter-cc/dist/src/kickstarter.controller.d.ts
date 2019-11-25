import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import { ConvectorController } from '@worldsibu/convector-core';
import { Kickstarter } from './kickstarter.model';
export declare class KickstarterController extends ConvectorController<ChaincodeTx> {
    create(kickstarter: Kickstarter): Promise<void>;
}
