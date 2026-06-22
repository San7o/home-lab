Devicetree
==========

To tell the kernel which hardware is available and where to find it, you need to
write a Device Tree Structure (.dts file). You use the interface from the SoC
manufacturer (.dtsi file) as a base class that defines specific connectors, so
the DTS represents the rest of the board.

They are localted in arch/arm64/boot/dts/ and you can build them with make:

.. code-block:: bash

    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
                         arch/arm64/boot/dts/arm/corstone1000.dtsi

Developers should keep their device trees in-kernel, maintaining their own fork
of the kernel. Only the SoC manufacturers actually upstream their device trees
as they represent the fully-featured description of their hardware.

DT Bindings
-----------

Devicetree Bindings are yaml files that specify how the kernel should parse the
Devicetree's properties.

For example, `Documentation/devicetree/bindings/arm/rockchip.pmu.yaml`:

.. code-block:: bash

    # SPDX-License-Identifier: GPL-2.0
    %YAML 1.2
    ---
    $id: http://devicetree.org/schemas/arm/rockchip/pmu.yaml#
    $schema: http://devicetree.org/meta-schemas/core.yaml#
    
    title: Rockchip Power Management Unit (PMU)
    
    maintainers:
      - Elaine Zhang <zhangqing@rock-chips.com>
      - Heiko Stuebner <heiko@sntech.de>
    
    description: |
      The PMU is used to turn on and off different power domains of the SoCs.
      This includes the power to the CPU cores.
    
    select:
      properties:
        compatible:
          contains:
            enum:
              - rockchip,px30-pmu
              - rockchip,rk3066-pmu
              - rockchip,rk3128-pmu
              - rockchip,rk3288-pmu
              - rockchip,rk3368-pmu
              - rockchip,rk3399-pmu
              - rockchip,rk3528-pmu
              - rockchip,rk3562-pmu
              - rockchip,rk3568-pmu
              - rockchip,rk3576-pmu
              - rockchip,rk3588-pmu
              - rockchip,rv1126-pmu
    
      required:
        - compatible
    
    properties:
      compatible:
        items:
          - enum:
              - rockchip,px30-pmu
              - rockchip,rk3066-pmu
              - rockchip,rk3128-pmu
              - rockchip,rk3288-pmu
              - rockchip,rk3368-pmu
              - rockchip,rk3399-pmu
              - rockchip,rk3528-pmu
              - rockchip,rk3562-pmu
              - rockchip,rk3568-pmu
              - rockchip,rk3576-pmu
              - rockchip,rk3588-pmu
              - rockchip,rv1126-pmu
          - const: syscon
          - const: simple-mfd
    
      reg:
        maxItems: 1
    
      power-controller:
        type: object
    
      reboot-mode:
        type: object
    
    required:
      - compatible
      - reg
    
    additionalProperties: false
    
    examples:
      - |
        pmu@20004000 {
          compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
          reg = <0x20004000 0x100>;
        };

Validate a binding:

.. code-block:: bash

   make dt_binding_check DT_SCHEMA_FILES=trivial-devices.yaml

Validate one DTS:

.. code-block:: bash

   make CHECK_DTBS=y qcom/sm8450-hdk.dtb

Validate one DTS against one binding:

.. code-block:: bash

   make CHECK_DTBS=y qcom/sm8450-hdk.dtb DT_SCHEMA_FILES=trivial-devices.yaml
