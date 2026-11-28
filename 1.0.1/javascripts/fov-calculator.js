(() => {
  let calculatorCount = 0;

  const mountCalculator = (placeholder) => {
    calculatorCount += 1;
    const suffix = calculatorCount.toString();
    const referenceId = `fov-reference-${suffix}`;
    const magnificationId = `fov-magnification-${suffix}`;
    const helpId = `fov-calculator-help-${suffix}`;
    const messageId = `fov-calculator-message-${suffix}`;

    const calculator = document.createElement("div");
    calculator.className = "fov-calculator";
    calculator.innerHTML = `
      <div class="fov-calculator__fields">
        <label class="fov-calculator__field" for="${referenceId}">
          <span>基準FOV（<code>MaximumFov</code>）</span>
          <span class="fov-calculator__input-group">
            <input id="${referenceId}" data-fov-reference type="number" min="0.01" max="179.99" step="any" inputmode="decimal" aria-describedby="${helpId} ${messageId}">
            <span>度</span>
          </span>
        </label>
        <label class="fov-calculator__field" for="${magnificationId}">
          <span>設定したい倍率</span>
          <span class="fov-calculator__input-group">
            <input id="${magnificationId}" data-fov-magnification type="number" min="1" step="any" inputmode="decimal" aria-describedby="${helpId} ${messageId}">
            <span>倍</span>
          </span>
        </label>
      </div>
      <p id="${helpId}" class="fov-calculator__help">入力値を変更すると計算結果が更新されます。</p>
      <p class="fov-calculator__result">
        <span><code>MinimumFov</code>へ設定する値</span>
        <strong><output data-fov-result for="${referenceId} ${magnificationId}" aria-live="polite">—</output><span>度</span></strong>
      </p>
      <p id="${messageId}" class="fov-calculator__message" data-fov-message aria-live="polite"></p>
    `;

    const paragraph = placeholder.parentElement;
    if (
      paragraph &&
      paragraph.tagName === "P" &&
      paragraph.childElementCount === 1 &&
      paragraph.textContent.trim() === ""
    ) {
      paragraph.replaceWith(calculator);
    } else {
      placeholder.replaceWith(calculator);
    }

    const referenceInput = calculator.querySelector("[data-fov-reference]");
    const magnificationInput = calculator.querySelector("[data-fov-magnification]");
    const resultOutput = calculator.querySelector("[data-fov-result]");
    const messageOutput = calculator.querySelector("[data-fov-message]");
    if (!referenceInput || !magnificationInput || !resultOutput || !messageOutput) return;

    const numberFormatter = new Intl.NumberFormat("ja-JP", {
      maximumFractionDigits: 3,
    });

    const clearResult = () => {
      resultOutput.textContent = "—";
    };

    const setValidity = (input, valid) => {
      input.setAttribute("aria-invalid", valid ? "false" : "true");
    };

    const calculate = () => {
      const referenceText = referenceInput.value.trim();
      const magnificationText = magnificationInput.value.trim();
      messageOutput.textContent = "";
      setValidity(referenceInput, true);
      setValidity(magnificationInput, true);

      if (!referenceText || !magnificationText) {
        clearResult();
        return;
      }

      const referenceFov = Number(referenceText);
      const magnification = Number(magnificationText);
      if (!Number.isFinite(referenceFov) || referenceFov <= 0 || referenceFov >= 180) {
        clearResult();
        setValidity(referenceInput, false);
        messageOutput.textContent = "基準FOVには、0より大きく180より小さい値を入力してください。";
        return;
      }
      if (!Number.isFinite(magnification) || magnification < 1) {
        clearResult();
        setValidity(magnificationInput, false);
        messageOutput.textContent = "設定したい倍率には、1以上の値を入力してください。";
        return;
      }

      const targetFov =
        (360 / Math.PI) *
        Math.atan(
          Math.tan((Math.PI * referenceFov) / 360) / Math.max(1, magnification),
        );
      if (!Number.isFinite(targetFov)) {
        clearResult();
        messageOutput.textContent = "入力値からFOVを計算できませんでした。";
        return;
      }

      resultOutput.textContent = numberFormatter.format(targetFov);
    };

    referenceInput.addEventListener("input", calculate);
    magnificationInput.addEventListener("input", calculate);
    calculate();
  };

  const initializeCalculators = () => {
    document.querySelectorAll("[data-fov-calculator]").forEach(mountCalculator);
  };

  if (typeof document$ !== "undefined") {
    document$.subscribe(initializeCalculators);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeCalculators);
  } else {
    initializeCalculators();
  }
})();
