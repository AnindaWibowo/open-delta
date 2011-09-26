package au.org.ala.delta.intkey.directives.invocation;

import java.util.Map;

import au.org.ala.delta.intkey.model.IntkeyContext;
import au.org.ala.delta.model.Character;

public class SetReliabilitiesDirectiveInvocation extends IntkeyDirectiveInvocation {
    private Map<Character, Float> _reliabilitiesMap;

    public SetReliabilitiesDirectiveInvocation(Map<Character, Float> reliabilitiesMap) {
        _reliabilitiesMap = reliabilitiesMap;
    }

    @Override
    public boolean execute(IntkeyContext context) {
        for (Character ch : _reliabilitiesMap.keySet()) {
            ch.setReliability(_reliabilitiesMap.get(ch));
        }

        return true;
    }
}