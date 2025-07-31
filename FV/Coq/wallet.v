(* Wallet.v *)

(* 导入自然数库 *)
Require Import Nat.

(* 定义钱包的状态：仅用一个余额来表示 *)
Record Wallet := {
  balance : nat (* Coq 中的 nat 是非负整数 *)
}.

(* 定义转账函数，尝试从钱包中扣除 n 元 *)
Definition withdraw (w : Wallet) (n : nat) : option Wallet :=
  if leb n (balance w) then
    Some {| balance := (balance w) - n |}
  else
    None.

(* 定理：如果成功扣款，余额永远不为负（在 Coq 中一定成立） *)
Theorem withdraw_preserves_nonnegative :
  forall (w : Wallet) (n : nat) (w': Wallet),
    withdraw w n = Some w' ->
    exists b, balance w' = b.
Proof.
  intros w n w' H.
  unfold withdraw in H.
  destruct (leb n (balance w)) eqn:Hle.
  - (* 成功取款 *)
    inversion H. subst.
    exists (balance w - n). reflexivity.
  - (* 不可能，因为返回值是 Some，但我们构造的是 None *)
    discriminate H.
Qed.