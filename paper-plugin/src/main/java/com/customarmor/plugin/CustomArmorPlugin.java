package com.customarmor.plugin;

import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.plugin.java.JavaPlugin;

public final class CustomArmorPlugin extends JavaPlugin {

    private ToolListener toolListener;
    private BuildProtection buildProtection;
    private LegendaryManager legendaryManager;

    @Override
    public void onEnable() {
        saveDefaultConfig();

        this.toolListener = new ToolListener(this);
        this.buildProtection = new BuildProtection(this);
        this.legendaryManager = new LegendaryManager(this, buildProtection);

        getServer().getPluginManager().registerEvents(toolListener, this);
        getServer().getPluginManager().registerEvents(buildProtection, this);
        getServer().getPluginManager().registerEvents(legendaryManager, this);

        legendaryManager.start();

        getLogger().info("CustomArmorTools actif : pioche 3x3, hache bucheron, houe fertile, reliques legendaires.");
    }

    @Override
    public void onDisable() {
        if (buildProtection != null) buildProtection.saveToDisk();
        if (legendaryManager != null) legendaryManager.saveToDisk();
    }

    @Override
    public boolean onCommand(CommandSender sender, Command command, String label, String[] args) {
        if (!(sender instanceof Player player)) {
            sender.sendMessage("Cette commande doit etre executee par un joueur.");
            return true;
        }

        switch (command.getName().toLowerCase()) {
            case "caxe" -> {
                player.getInventory().addItem(toolListener.createAxeBucheron());
                return true;
            }
            case "cpickaxe" -> {
                player.getInventory().addItem(toolListener.createPickaxeOmni());
                return true;
            }
            case "choe" -> {
                player.getInventory().addItem(toolListener.createHoeFertile());
                return true;
            }
            case "legendary" -> {
                return legendaryManager.handleCommand(player, args);
            }
        }
        return false;
    }
}
