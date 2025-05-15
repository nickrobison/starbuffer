module RingBuffer

module US = FStar.SizeT

let max_size = 32sz

let threshold (b: bool) (v: nat): nat
= if b then v else 0

let len
(k_in k_out: (v:nat{v < US.v max_size})):
v:nat{v < US.v max_size}
= k_out - k_in + threshold (k_out < k_in) (US.v max_size)
