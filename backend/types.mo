import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
module {
  public type Member = {
    name : Text;
    age : Nat;
  };

  public type Status = {
    #Open;
    #Accepted;
    #Rejected;
  };

  public type Proposal = {
    status : Status;
    creator : Principal;
    manifesto : Text;
    id : Nat;
  };
};
