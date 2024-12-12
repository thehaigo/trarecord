const NativeBridge = {
  mounted() {
    this.handleEvent("open_safari", ({ url }) => {
      try {
        window.webkit.messageHandlers.openSafari.postMessage(url);
      } catch {}
    });
  },
};

export default NativeBridge;
