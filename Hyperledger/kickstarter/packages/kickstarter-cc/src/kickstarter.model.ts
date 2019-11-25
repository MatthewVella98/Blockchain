import * as yup from 'yup';
import {
  ConvectorModel,
  Default,
  ReadOnly,
  Required,
  Validate
} from '@worldsibu/convector-core-model';

export class Kickstarter extends ConvectorModel<Kickstarter> {
  @ReadOnly()
  @Required()
  public readonly type = 'io.worldsibu.kickstarter';

  @Required()
  @Validate(yup.string())
  public name: string;

  
  type Request = {
    description: string, 
    value: number, 
    recipient: string, 
    complete: boolean, 
    approvalCount: number,
    approvals = new Map<string, boolean>()

  } 

  @Required()
  public let request: Request[]; 

  @Required()
  public let manager: string;

  @Required()
  public let minimumContribution = 100; 
  // public Approvers = new Map<string, boolean>(); 


  @ReadOnly()
  @Required()
  @Validate(yup.number())
  public created: number;

  @Required()
  @Validate(yup.number())
  public modified: number;

} 

// Creation of a Hashtable in TypeScript 
interface HashTable<T> {
  [key: string]: T;
}
