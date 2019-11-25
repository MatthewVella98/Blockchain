import { ConvectorModel } from '@worldsibu/convector-core-model';
export declare class Aggreement extends ConvectorModel<Aggreement> {
    readonly type: string;
    name: string;
    title: string;
    description: string;
    party1: string;
    party2: string;
    agreeParty1: boolean;
    agreeParty2: boolean;
    finishDate: Date;
    created: number;
    modified: number;
}
