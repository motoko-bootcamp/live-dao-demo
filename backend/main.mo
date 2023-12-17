import Map "mo:map/Map";
import { phash; nhash } "mo:map/Map";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Types "types";
import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Vector "mo:vector";
import HttpTypes "mo:http-types";
actor {

  public type Result<A, B> = Result.Result<A, B>;
  public type Member = Types.Member;
  public type Status = Types.Status;
  public type Proposal = Types.Proposal;

  stable let members = Map.new<Principal, Member>();

  public shared ({ caller }) func addMember(member : Member) : async Result<Text, Text> {
    switch (Map.get<Principal, Member>(members, phash, caller)) {
      case (?member) {
        return #err("You are already registered!");
      };
      case (null) {
        ignore Map.put<Principal, Member>(members, phash, caller, member);
        return #ok("Welcome to the DAO!");
      };
    };
  };

  public shared query ({ caller }) func getMember() : async Result<Member, Text> {
    switch (Map.get<Principal, Member>(members, phash, caller)) {
      case (?member) {
        return #ok(member);
      };
      case (null) {
        return #err("You are not registered!");
      };
    };
  };

  public query func getAllMembers() : async [Member] {
    Iter.toArray(Map.vals<Principal, Member>(members));
  };

  public query func getNumberOfMember() : async Nat {
    Map.size<Principal, Member>(members);
  };

  // Proposals
  stable var proposalId = 0;
  stable let proposals = Vector.new<Proposal>();

  public shared ({ caller }) func createProposal(manifesto : Text) : async Result<Text, Text> {
    let proposal : Proposal = {
      creator = caller;
      manifesto = manifesto;
      status = #Open;
      id = proposalId;
    };
    Vector.add<Proposal>(proposals, proposal);
    proposalId := proposalId + 1;
    return #ok("Proposal created!");
  };

  public query func getAllProposals() : async [Proposal] {
    Iter.toArray(Vector.vals<Proposal>(proposals));
  };
  // Vote

  public shared ({ caller }) func vote(proposalId : Nat, yesOrNo : Bool) : async Result<(), Text> {
    switch (Vector.getOpt<Proposal>(proposals, proposalId)) {
      case (null) {
        return #err("Proposal does not exist!");
      };
      case (?proposal) {
        if (proposal.status == #Rejected or proposal.status == #Accepted) {
          return #err("Proposal is over!");
        };
        if (yesOrNo) {
          let newProposal = {
            creator = proposal.creator;
            manifesto = proposal.manifesto;
            status = #Accepted;
            id = proposal.id;
          };
          manifesto := proposal.manifesto;
          Vector.put<Proposal>(proposals, proposalId, newProposal);
        } else {
          let newProposal = {
            creator = proposal.creator;
            manifesto = proposal.manifesto;
            status = #Rejected;
            id = proposal.id;
          };
          Vector.put<Proposal>(proposals, proposalId, newProposal);
        };
        return #ok();
      };
    };
  };

  var manifesto = "Let’s f∞cking build!";
  public query func http_request(request : HttpTypes.Request) : async HttpTypes.Response {
    return {
      status_code = 200;
      headers = [
        ("Content-Type", "text/html; charset=utf-8"),
      ];
      body = Text.encodeUtf8(manifesto);
      streaming_strategy = null;
      upgrade = null;
    };

  };

};
