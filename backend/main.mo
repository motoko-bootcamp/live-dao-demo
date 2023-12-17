import Map "mo:map/Map";
import { phash } "mo:map/Map";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Types "types";
actor {

  public type Result<A, B> = Result.Result<A, B>;
  public type Member = Types.Member;

  public query func greet(name : Text) : async Text {
    return "Hello " # name;
  };

  var counter : Nat = 0;

  public func inc() : async () {
    counter := counter + 1;
    return;
  };

  public query func get() : async Nat {
    return counter;
  };

  let members = Map.new<Principal, Member>();

  public shared ({ caller }) func addMember(member : Member) : async Result<Text, Text> {
    switch(Map.get<Principal, Member>(members, phash, caller)){
        case(? member){
            return #err("You are already registered!")
        };
        case(null){
            ignore Map.put<Principal, Member>(members, phash, caller, member);
            return #ok("Welcome to the DAO!");
        };
    };
  };

  public shared query ({ caller }) func getMember() : async Result<Member, Text> {
    switch(Map.get<Principal, Member>(members, phash, caller)){
        case(? member){
            return #ok(member);
        };
        case(null){
            return #err("You are not registered!");
        };
    };
  };

};
