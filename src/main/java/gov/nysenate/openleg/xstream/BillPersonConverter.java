package gov.nysenate.openleg.xstream;

import gov.nysenate.openleg.model.Person;

import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

public class BillPersonConverter implements Converter {

	@Override
	public void marshal(Object value, HierarchicalStreamWriter writer, MarshallingContext context) {
		if(value instanceof Person) {
			writer.addAttribute("sponsor", ((Person)value).getFullname());
		}
	}

	@Override
	public Object unmarshal(HierarchicalStreamReader writer, UnmarshallingContext context) {
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean canConvert(Class clazz) {
		return (clazz == Person.class);
	}

}
