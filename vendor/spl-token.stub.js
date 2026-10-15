/* Local stand-in. Wallet reads stay gated; this only keeps the script tag from 404ing. */
var splToken = {
  getAssociatedTokenAddress: async function () {
    throw new Error("SPL token library not bundled");
  }
};
