package au.org.ala.delta.slotfile.model;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;

import au.org.ala.delta.directives.validation.DirectiveException;
import au.org.ala.delta.editor.slotfile.model.SlotFileRepository;
import au.org.ala.delta.model.Attribute;
import au.org.ala.delta.model.Character;
import au.org.ala.delta.model.CharacterType;
import au.org.ala.delta.model.DeltaDataSet;
import au.org.ala.delta.model.Item;
import au.org.ala.delta.model.MutableDeltaDataSet;
import au.org.ala.delta.model.TextCharacter;
import au.org.ala.delta.model.UnorderedMultiStateCharacter;
import junit.framework.TestCase;

public class SlotFileConsistencyTest extends TestCase {
	
	@Test
	public void testSlotFile1() throws DirectiveException {
		
		SlotFileRepository repo = new SlotFileRepository();
		MutableDeltaDataSet dataset = repo.newDataSet();
		for (int i = 0; i < 100; i += 2) {
			au.org.ala.delta.model.Character ch1 = addUnorderedCharacter(dataset, "character " + i, "state1_" + i, "state2_" + i, "state3_" + i );
			au.org.ala.delta.model.Character ch2 = addUnorderedCharacter(dataset, "character " + (i+1), "state1_" + (i+1), "state2_" + (i+1), "state3_" + (i+1));
			dataset.deleteCharacter(ch1);
			Item item1 = addItem(dataset, "Item " + i);
			Item item2 = addItem(dataset, "Item " + (i + 1));
			dataset.deleteItem(item1);					
			Attribute attr = dataset.addAttribute(ch2.getCharacterId(), item2.getItemNumber());
			attr.setValueFromString("1");
			
		}
		
//		for (int i = 0; i < 100; i += 2) {
//			Item item1 = addItem(dataset, "Item " + i);
//			Item item2 = addItem(dataset, "Item " + (i + 1));
//			dataset.deleteItem(item1);
//		}
		
		dumpDataset(dataset);
		dataset.close();
				
	}
	
	private Item addItem(MutableDeltaDataSet dataset, String itemDesc) {
		Item item = dataset.addItem();
		item.setDescription(itemDesc);
		return item;
	}
	
	private au.org.ala.delta.model.Character addTextCharacter(MutableDeltaDataSet dataset, String text) {
		TextCharacter ch = (TextCharacter) dataset.addCharacter(CharacterType.Text);
		ch.setDescription(text);
		return ch;
	}
	
	private UnorderedMultiStateCharacter addUnorderedCharacter(MutableDeltaDataSet dataset, String description, String...states) {
		UnorderedMultiStateCharacter ch = (UnorderedMultiStateCharacter) dataset.addCharacter(CharacterType.UnorderedMultiState);
		ch.setDescription(description);
		int i = 0;
		for (String s : states) {
			ch.addState(++i);
			ch.setState(i, s);
		}
		return ch;
	}
	
	private void dumpDataset(DeltaDataSet dataset) {
		for (int i = 1; i <= dataset.getNumberOfCharacters(); ++i) {
			Character ch = dataset.getCharacter(i);
			out("Character %d: %s", i, ch.getDescription());
			if (ch instanceof UnorderedMultiStateCharacter) {
				UnorderedMultiStateCharacter uo = (UnorderedMultiStateCharacter) ch;
				out("  States: %s", StringUtils.join(uo.getStates(), ", "));
			}
		}
		
		for (int i = 1; i <= dataset.getMaximumNumberOfItems(); ++i) {
			Item item = dataset.getItem(i);
			out("Item %d: %s", i, item.getDescription());
		}
	}
	
	private static void out(String format, Object ...args) {
		System.out.println(String.format(format, args));
	}
	

}
